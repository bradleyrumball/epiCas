module EpiCas
  class SessionsController < ::ApplicationController
  
    def app_logout
      @application_title = EpiCas::Settings.app_title
      @cas_title         = EpiCas::Settings.cas_title
      render layout: false
    end  
  
    # Log out from Portal
    def cas_logout
      reset_session
      redirect_to EpiCas::Settings.cas_logout_url
    end
  
  end
end