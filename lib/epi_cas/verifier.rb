module EpiCas
  class Verifier < Struct.new(:username, :user_class)
    def find_and_verify_and_update_user
      return unless allow_authentication?
    
      resource = user_class.find_by_username(ldap_info.uid)
      resource.update_ldap_info(ldap_info.attributes) if resource && resource.respond_to?(:update_ldap_info)
      resource
    end
  
    def verify_and_build_new_user
      return unless allow_authentication? && whitelist_checker.allow_creation?
    
      resource = user_class.new
      resource.update_ldap_info(ldap_info.attributes)
      resource.generate_attributes_from_ldap_info if resource.respond_to?(:generate_attributes_from_ldap_info)
      resource
    end
  
    private
      def allow_authentication?
        ldap_info.found? && whitelist_checker.allow_authentication?
      end
  
      def ldap_info(klass = LdapInfo)
        @ldap_info ||= klass.new(username, user_class)
      end
    
      def whitelist_checker(klass = WhitelistChecker)
        @whitelist ||= klass.new(ldap_info.dn, ldap_info.uid, ldap_info.ou, user_class)
      end
  end
end