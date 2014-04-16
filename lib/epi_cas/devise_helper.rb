module EpiCas
  module DeviseHelper
    module ClassMethods
      def auth_method 
        EpiCas::Settings.epi_cas['auth_method'].to_s.downcase
      end
    
      ### This overrides the method in the auth gem to do additional processing:
      # - Get LDAP attributes (givenName, sn, dn, ou, mail) 
      # - OR When LDAP is down get the record from database
      # Check whitelist for authentication (Staff, Staff Honorary, Staff Visiting)
      # - Update LDAP attributes for existing users 
      # - OR Do move department thing (find_old_user_with_new_username) and update attributes
      # - OR Check whitelist for creation and store the attributes (same list as authentication)
      # Update other attributes (e.g. departments / sections) if any of the above 3 were successful and data are changed.
      
      def authenticate_with_cas_ticket(ticket, authenticator = EpiCas::TicketAuthenticator)
        authenticator.new(ticket).authenticate_ticket
      end

      # This is generally only used where CAS is unavailable, e.g. locally
      def authenticate_with_ldap(attributes={}, authenticator = EpiCas::LdapAuthenticator)
        authenticator.new(attributes).authenticate_ldap
      end
    end
  
    module InstanceMethods
      # Override this method in your app if you wish to do somethign special
      def update_ldap_info(ldap_info)
        assign_attributes(ldap_info)
        generate_attributes_from_ldap_info
      end
    
      # Override this method in your app if you wish to do somethign special
      def generate_attributes_from_ldap_info
        self.username = self.uid
        self.email    = self.mail
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end