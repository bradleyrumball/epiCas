module EpiCas
  class Engine < Rails::Engine
    isolate_namespace EpiCas
    
    config.after_initialize do
      if EpiCas::Settings['auth_method'].to_s.downcase == 'cas'
        Devise::FailureApp.class_eval do
          def redirect
            store_location!
            if flash[:timedout] && flash[:alert]
              flash.keep(:timedout)
              flash.keep(:alert)
            end
            redirect_to redirect_url
          end
        end
      end
    end
    
  end
end