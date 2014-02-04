require 'rails/generators/named_base'

module EpiCas
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)
    include Rails::Generators::ResourceHelpers
    
    desc "Adds an initializer, updates the model, and adds required routes."
    
    def create_config
      copy_file "epi_cas_settings.yml", "config/epi_cas_settings.yml"
    end
    
    def install_ldap_lookup
      invoke 'sheffield_ldap_lookup:install'
    end
    
    def copy_devise_config
      invoke 'devise:install'
    end
    
    def update_devise_config
      file_path = 'config/initializers/devise.rb'
      
      cas_config = <<-RUBY
  # Use CAS to log in, location configured in epi_cas_settings.yml
  config.cas_base_url = EpiCas::Settings.cas_base_url
  # Redirect log out to app logout page, which then uses CAS to log out
  config.cas_logout_url = EpiCas::Settings.app_logout_url
  config.cas_logout_url_param = 'destination'
  config.cas_enable_single_sign_out = true
  # By default, devise_cas_authenticatable will create users.  If you would rather
  # require user records to already exist locally before they can authenticate via
  # CAS, uncomment the following line
      RUBY
      gsub_file file_path, /(?:# ?)?config\.authentication_keys = \[ :email \]/, 'config.authentication_keys = [ :username ]'
      gsub_file file_path, /config\.case_insensitive_keys = \[ :email \]/, 'config.case_insensitive_keys = [ :username ]'
      gsub_file file_path, /config\.strip_whitespace_keys = \[ :email \]/, 'config.strip_whitespace_keys = [ :username ]'
      inject_into_file file_path, cas_config, after: "Devise.setup do |config|\n"
    end
    
    def update_user_model
      file_path = "app/models/#{file_name}.rb"
      # raise ArgumentError.new("Could not find #{file_path}. Have you generated it with Devise?") unless File.exist?(file_path)
      inject_into_file file_path, "extend EpiCas::DeviseHelper", after: "< ActiveRecord::Base\n"
      gsub_file file_path, /:database_authenticatable/, ':"#{auth_method}_authenticatable"'
    end
    
    def generate_migration
      invoke 'epi_cas:migration', [name]
    end

    def add_epi_cas_routes
      route "get '/app_log_out' => 'epi_cas/sessions#app_log_out'"
      route "get '/cas_log_out' => 'epi_cas/sessions#cas_log_out'"
    end
  end
end
