module EpiCas::DeviseHelper
  module ClassMethods
    def auth_method 
      EpiCas::Settings.epi_cas['auth_method'].to_s.downcase
    end
    
    ############## Override LDAP Authentication for change department ##############
    def self.authenticate_with_cas_ticket(ticket, verifier_class = EpiCas::UserAuthentications::Verifier)
      ::Devise.cas_client.validate_service_ticket(ticket) unless ticket.has_been_validated?

      if ticket.is_valid?
        username = (ticket.respond_to?(:user) ? ticket.user : ticket.response.user).downcase

        ### - Get LDAP attributes (givenName, sn, dn, ou, mail) 
        ### - OR When LDAP is down get the record from database
        ### Check whitelist for authentication (Staff, Staff Honorary, Staff Visiting)
        ### - Update LDAP attributes for existing users 
        ### - OR Do move department thing (find_old_user_with_new_username) and update attributes
        ### - OR Check whitelist for creation and store the attributes (same list as authentication)
        ### Update other attributes (e.g. departments / sections) if any of the above 3 were successful and data are changed.

        verifier = verifier_class.new(username)
        resource = verifier.find_and_verify_and_update_user || verifier.verify_and_build_new_user

        if resource
          resource.save if resource.changed?
        end
        resource
      end
    end

    def self.authenticate_with_ldap(attributes={}, verifier_class = EpiCas::UserAuthentications::Verifier)
      auth_key = self.authentication_keys.first
      return nil unless attributes[auth_key].present?

      auth_key_value = (self.case_insensitive_keys || []).include?(auth_key) ? attributes[auth_key].downcase : attributes[auth_key]

      verifier = verifier_class.new(auth_key_value)
      resource = verifier.find_and_verify_and_update_user || verifier.verify_and_build_new_user

      if resource.try(:valid_ldap_authentication?, attributes[:password])
        resource.save if resource.changed?
        resource
      end
    end
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end