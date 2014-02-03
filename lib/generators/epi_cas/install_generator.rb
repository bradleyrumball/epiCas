require 'rails/generators/named_base'

module EpiCas
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)
    include Rails::Generators::ResourceHelpers
    
    #  DeviseLdapAuthenticatable::InstallGenerator
      
    
    def create_config
      copy_file "initializer.rb", "config/initializers/epi_cas.rb"
    end
    
    def update_user_model
      inject_into_file "app/models/#{file_name}.rb", "extend EpiCas::DeviseHelper", after: "< ActiveRecord::Base\n"
      gsub_file "app/models/#{file_name}.rb", /:database_authenticatable/, ':"#{auth_method}_authenticatable"' if options.update_model?
    end



    desc "Generates a model with the given NAME (if one does not exist) with EpiCas " <<
         "configuration plus a migration file and required routes."

    class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true

    def add_epi_cas_routes
      epi_cas_routes  =  "get '/app_log_out' => 'epi_cas/sessions#app_log_out'\n"
      epi_cas_routes  << "get '/cas_log_out' => 'epi_cas/sessions#cas_log_out'"
      route epi_cas_routes
    end
  end
end
