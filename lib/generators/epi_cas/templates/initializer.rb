# Use this initializer to configure EpiCas for your app
EpiCas.configure do |config|
  # The title of your application, shown in the title of the log out page
  # config.app_logout = 'Application'
  
  # The title of the CAS service, shown in the log out link on the log out page: "Log out of #{@cas_title}"
  # config.cas_title  = 'Online Services'
  
  # The urls for the CAS services you are using
  config.cas_base_url   = 'https://some.url/cas'
  config.cas_log_out_url = 'https://some.url/cas/logout'
end