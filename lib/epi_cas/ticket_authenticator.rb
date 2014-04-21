module EpiCas
  class TicketAuthenticator < Struct.new(:ticket, :user_class)
    
    def authenticate_ticket
      connection_attempts = 1
      begin
        validate_ticket unless ticket.has_been_validated?
      rescue Errno::ECONNRESET
        if connection_attempts == 3
          return
        else
          connection_attempts += 1
          retry
        end
      end
      
      verify_user if ticket.is_valid?
    end
    
    private
      def verify_user
        resource = verifier.find_and_verify_and_update_user || verifier.verify_and_build_new_user
        resource.save if resource && resource.changed?
        resource
      end
    
      def validate_ticket(cas_client = ::Devise.cas_client)
        cas_client.validate_service_ticket(ticket) unless ticket.has_been_validated?
      end
    
      def verifier(verifier_class = EpiCas::Verifier)
        @verifier ||= verifier_class.new(username, user_class)
      end
    
      def username
        @username ||= (ticket.respond_to?(:user) ? ticket.user : ticket.response.user).downcase
      end
    end
end