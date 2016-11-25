require 'spec_helper'
require 'generator_spec'
require 'generators/epi_cas/install_generator'

describe EpiCas::InstallGenerator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(User)
  before(:all) do
    prepare_destination
    mkdir_p(File.join(destination_root, 'app', 'models'))
    mkdir_p(File.join(destination_root, 'config', 'initializers'))

    File.open(File.join(destination_root, 'app', 'models', 'user.rb'), 'w') do |file|
      file.write <<-RUBY
class User < ApplicationRecord
  devise :database_authenticatable
end
      RUBY
    end

    File.open(File.join(destination_root, 'config', 'application.rb'), 'w') do |file|
      file.write <<-RUBY
module Moo
  class Application < Rails::Application
  end
end
      RUBY
    end

    File.open(File.join(destination_root, 'config', 'initializers', 'devise.rb'), 'w') do |file|
      file.write <<-RUBY
Devise.setup do |config|
  config.secret_key = 'fe13a1c39a6f6863ff6bf9ceeb1ed9b745572f1576e0a5cdea2717d9b585404dcf0bb6ab0076af41616c85e752be57cc75c00472ea2faa9ddde9d690ca78c6d0'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  # config.mailer = 'Devise::Mailer'
  # config.parent_mailer = 'ActionMailer::Base'
  require 'devise/orm/active_record'
  # config.authentication_keys = [:email]
  # config.request_keys = []
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  # config.params_authenticatable = true
  # config.http_authenticatable = false
  # config.http_authenticatable_on_xhr = true
  # config.http_authentication_realm = 'Application'
  # config.paranoid = true
  config.skip_session_storage = [:http_auth]
  # config.clean_up_csrf_token_on_authentication = true
  # config.reload_routes = true
  config.stretches = Rails.env.test? ? 1 : 11
  config.pepper = '67b2d394f92301140296347e77c8baf1273ff57b15f316c8d901a333aff2c4d103878b5574ec55d307f8071c99f60d2c887a68595b9c9edd1dcb04cef9abd2e2'
  # config.send_password_change_notification = false
  # config.allow_unconfirmed_access_for = 2.days
  # config.confirm_within = 3.days
  config.reconfirmable = true
  # config.confirmation_keys = [:email]
  # config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
  # config.extend_remember_period = false
  # config.rememberable_options = {}
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  # config.timeout_in = 30.minutes
  # config.lock_strategy = :failed_attempts
  # config.unlock_keys = [:email]
  # config.unlock_strategy = :both
  # config.maximum_attempts = 20
  # config.unlock_in = 1.hour
  # config.last_attempt_warning = true
  # config.reset_password_keys = [:email]
  config.reset_password_within = 6.hours
  # config.sign_in_after_reset_password = true
  # config.encryptor = :sha512
  # config.scoped_views = false
  # config.default_scope = :user
  # config.sign_out_all_scopes = true
  # config.navigational_formats = ['*/*', :html]
  config.sign_out_via = :delete
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end
  # config.router_name = :my_engine
  # config.omniauth_path_prefix = '/my_engine/users/auth'
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

  it "updates the model to use epi_cas" do
    assert_file "app/models/user.rb", /include EpiCas::DeviseHelper/
    assert_file "app/models/user.rb", /^((?!devise).)*/
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

  it "creates the migration file" do
    assert_migration 'db/migrate/add_ldap_info_and_clean_up_users.rb'
  end

end
