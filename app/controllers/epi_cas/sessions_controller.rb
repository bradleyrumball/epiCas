module EpiCas
  class SessionsController < ::ApplicationController
    skip_authorization_check if defined?('skip_authorization_check')
    def app_logout
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