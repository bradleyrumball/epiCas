class EpiCas::SessionsController < EpiCasController
  
  def app_logout
    @application_title = 'Incident Contacts'
    @cas_title         = Settings.auth['cas_title']
    render :layout => false
  end  
  
end