module EpiCas
  class LdapInfo < Struct.new(:username, :user_class)
    
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
      def get_ldap_info(setting_class = Settings)
        begin
          return get_ldap_info_from_database if setting_class.read_only
          lookup = ldap_finder.lookup
          return {} if lookup.blank?
          base_info = {
            uid:       lookup['uid'][0].to_s,
            givenname: lookup['givenname'][0].to_s,
            sn:        lookup['sn'][0].to_s,
            mail:      lookup['mail'][0].to_s.downcase,
            dn:        lookup['dn'][0].to_s, 
            ou:        lookup['ou'][0].to_s,
          }
          
          base_info[:person_code]  = lookup['shefpersoncode'][0].to_s if lookup['shefpersoncode'].any?
          base_info[:reg_number]   = lookup['shefregnumber'][0].to_s if lookup['shefregnumber'].any?
          base_info[:ucard_number] = lookup['sheflibrarynumber'][0].to_s if lookup['sheflibrarynumber'].any?
          
          base_info
        rescue
          # If LDAP server is down, fallback to existing records.
          get_ldap_info_from_database
        end
      end

      def get_ldap_info_from_database(model = user_class)
        existing_user = model.find_by_username(username)
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

      def ldap_finder(ldap_finder_class = SheffieldLdapLookup::LdapFinder)
        @ldap_finder ||= ldap_finder_class.new(username)
      end
  end
end