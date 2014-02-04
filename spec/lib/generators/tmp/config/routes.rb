TestApp::Application.routes.draw do
  get '/cas_log_out' => 'epi_cas/sessions#cas_log_out'
  get '/app_log_out' => 'epi_cas/sessions#app_log_out'
end
