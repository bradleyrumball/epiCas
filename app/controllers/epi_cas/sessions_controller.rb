module EpiCas
  class SessionsController < ::ApplicationController
  
    def app_logout
      @application_title = EpiCas::Settings.app_title
      @cas_title         = EpiCas::Settings.cas_title
      
      @after_logout_url  = EpiCas::Settings.key?('after_logout_url') ? EpiCas::Settings.after_logout_url : main_app.root_path
      
      render layout: false
    end  
  
    # Log out from Portal
    def cas_logout
      reset_session
      redirect_to EpiCas::Settings.cas_logout_url
    end
  
  end
end