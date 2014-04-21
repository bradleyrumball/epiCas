module EpiCas
  class LdapAuthenticator < Struct.new(:attributes, :user_class)
    
    def authenticate_ldap
      verify_user if attributes[:username].present?
    end
    
    private
      def verify_user
        resource = verifier.find_and_verify_and_update_user || verifier.verify_and_build_new_user
        if resource.try(:valid_ldap_authentication?, attributes[:password])
          resource.save if resource.changed?
          resource
        end
      end
      
      def verifier(verifier_class = EpiCas::Verifier)
        @verifier ||= verifier_class.new(username, user_class)
      end
    
      def username
        @username ||= attributes[:username].downcase
      end
  end
end