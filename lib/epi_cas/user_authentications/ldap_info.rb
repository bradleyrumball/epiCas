module EpiCas
  module UserAuthentications
    class LdapInfo < Struct.new(:username)
      def attributes
        @attributes ||= get_ldap_info
      end

      def uid
        attributes[:uid]
      end

      def mail
        attributes[:mail]
      end

      def dn
        attributes[:dn]
      end

      def found?
        !attributes.empty?
      end

      private
        def get_ldap_info(ldap_error = Net::LDAP::LdapError, fallback_model_class = User)
          begin
            lookup = ldap_finder.lookup
            return {} if lookup.blank?
            {
              uid:       lookup['uid'][0].to_s,
              givenname: lookup['givenname'][0].to_s,
              sn:        lookup['sn'][0].to_s,
              mail:      lookup['mail'][0].to_s.downcase,
              dn:        lookup['dn'][0].to_s, 
              ou:        lookup['ou'][0].to_s
            }
          rescue ldap_error
            # If LDAP server is down, fallback to existing records.
            existing_user = fallback_model_class.find_by_username(username)
            return {} unless existing_user
            {
             uid:       existing_user.uid,
             givenname: existing_user.givenname,
             sn:        existing_user.sn,
             mail:      existing_user.mail,
             dn:        existing_user.dn,
             ou:        existing_user.ou
            }
          end
        end

        def ldap_finder(ldap_finder_class = SheffieldLdapLookup::LdapFinder)
          @ldap_finder ||= ldap_finder_class.new(username)
        end
    end
  end
end