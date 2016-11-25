module EpiCas
  class Engine < Rails::Engine
    isolate_namespace EpiCas

    config.after_initialize do
      auth_method = 'cas'
      begin
        # Try to read the current auth method
        auth_method = EpiCas::Settings['auth_method'].to_s.downcase
      rescue Errno::ENOENT
        # Use default above if file read failed (e.g. initial install)
      end

      if auth_method == 'cas'
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
