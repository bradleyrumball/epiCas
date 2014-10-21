module EpiCas
  class SessionsController < ::ActionController::Base
    def app_logout
      reset_session
      @application_title = EpiCas::Settings.app_title
      @cas_title         = EpiCas::Settings.cas_title
      
      @go_back_to_app_url  = EpiCas::Settings.key?('go_back_to_app_url') ? EpiCas::Settings.go_back_to_app_url : main_app.root_path
      
      render layout: false
    end  
  
    # Log out from Portal
    def cas_logout
      reset_session
      redirect_to EpiCas::Settings.cas_logout_url
    end
  
  end
end