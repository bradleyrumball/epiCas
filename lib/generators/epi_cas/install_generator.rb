require 'rails/generators/named_base'

module EpiCas
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)
    include Rails::Generators::ResourceHelpers
    argument :install_devise, type: :boolean, default: true
    
    desc "Adds an initializer, updates the model, and adds required routes."
    
    def create_config
      copy_file "epi_cas_settings.yml", "config/epi_cas_settings.yml"
    end
    
    def copy_ldap_file
      copy_file "ldap.yml", "config/ldap.yml"
    end
    
    def install_ldap_lookup
      invoke 'sheffield_ldap_lookup:install'
    end
    
    def update_application_rb
      inject_into_file 'config/application.rb', before: /^module \w+/ do
<<-RUBY
# Require gems used by epi_cas
require 'devise'
require 'devise_cas_authenticatable'
require "devise_ldap_authenticatable"
require 'sheffield_ldap_lookup'
RUBY
      end
    end
    
    def copy_devise_config
      invoke 'devise:install' if install_devise
    end
    
    def create_devise_model
      invoke 'devise', [class_name]
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
      inject_into_file file_path, "  include EpiCas::DeviseHelper\n", after: "< ActiveRecord::Base\n"
      gsub_file file_path, '# Include default devise modules. Others available are:', ''
      gsub_file file_path, '# :confirmable, :lockable, :timeoutable and :omniauthable', ''
      gsub_file file_path, /devise (:\w+,?\s*)+/, ''
    end
    
    def mount_engine
      route 'mount EpiCas::Engine, at: "/"'
    end
    
    def generate_migration
      invoke 'epi_cas:migration', [name]
    end
  end
end
