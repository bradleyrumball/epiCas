require 'spec_helper'
require 'generator_spec'
require 'generators/epi_cas/install_generator'


describe EpiCas::InstallGenerator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(user)
  
  context "Missing pre-requesites" do
    it "throws an error if the user model does not exist" do
      prepare_destination
      lambda{ run_generator }.should raise_error(ArgumentError)
    end
  end
  
  context "Pre-requisites met" do
    before(:all) do
      prepare_destination
      mkdir_p(File.join(destination_root, 'app', 'models'))
      mkdir_p(File.join(destination_root, 'config', 'initializers'))
    
      File.open(File.join(destination_root, 'app', 'models', 'user.rb'), 'w') do |file|
        file.write <<-RUBY
class User < ActiveRecord::Base
  devise :database_authenticatable
end
        RUBY
      end
    
      File.open(File.join(destination_root, 'config', 'routes.rb'), 'w') do |file|
        file.write <<-RUBY
TestApp::Application.routes.draw do
end
        RUBY
      end
      run_generator
    end
  
    it "creates the initializer file" do
      assert_file "config/epi_cas_settings.yml"
    end
    
    it "updates the devise config file" do
      assert_file "config/initializers/devise.rb", /config\.cas_base_url = EpiCas::Settings.cas_base_url/
      assert_file "config/initializers/devise.rb", /config\.cas_logout_url = EpiCas::Settings.app_logout_url/
      assert_file "config/initializers/devise.rb", /config\.cas_logout_url_param = 'destination'/
      assert_file "config/initializers/devise.rb", /config\.cas_enable_single_sign_out = true/
      assert_file "config/initializers/devise.rb", /config\.authentication_keys = \[ :username \]/
      assert_file "config/initializers/devise.rb", /config\.case_insensitive_keys = \[ :username \]/
      assert_file "config/initializers/devise.rb", /config\.strip_whitespace_keys = \[ :username \]/
    end
    
    it 'adds the log out routes' do
      assert_file 'config/routes.rb', /get '\/cas_log_out' => 'epi_cas\/sessions#cas_log_out'/
      assert_file 'config/routes.rb', /get '\/app_log_out' => 'epi_cas\/sessions#app_log_out'/
    end
    
    it "creates the migration file" do
      assert_migration 'db/migrate/add_ldap_info_to_users.rb'
    end
    
  end
end