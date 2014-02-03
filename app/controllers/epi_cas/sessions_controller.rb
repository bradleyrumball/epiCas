class EpiCas::SessionsController < EpiCasController
  
  def app_log_out
    @application_title = 'Incident Contacts'
    @cas_title         = EpiCas.configuration.cas_title
    render layout: false
  end  
  
  # Log out from Portal
  def cas_log_out
    reset_session
    redirect_to EpiCas.configuration.cas_log_out_url
  end
  
end