# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: epi_cas 1.3.18 ruby lib

Gem::Specification.new do |s|
  s.name = "epi_cas".freeze
  s.version = File.read('VERSION')

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ant Nettleship".freeze, "James Gregory".freeze, "Shuo Chen".freeze]
  s.date = "2016-11-25"
  s.description = "Adds Devise to your app and installs (if it's not there already). Provides a generator to create a model (if not already there) add the appropriate migrations, routes, and views.".freeze
  s.email = "info@epigenesys.org.uk".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".gitlab-ci.yml",
    ".rspec",
    ".ruby-version",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/controllers/epi_cas/sessions_controller.rb",
    "app/models/epi_cas/settings.rb",
    "app/views/epi_cas/sessions/app_logout.html.haml",
    "config/routes.rb",
    "epi_cas.gemspec",
    "lib/epi_cas.rb",
    "lib/epi_cas/devise_helper.rb",
    "lib/epi_cas/engine.rb",
    "lib/epi_cas/ldap_authenticator.rb",
    "lib/epi_cas/ldap_info.rb",
    "lib/epi_cas/ticket_authenticator.rb",
    "lib/epi_cas/verifier.rb",
    "lib/epi_cas/whitelist_checker.rb",
    "lib/generators/epi_cas/install_generator.rb",
    "lib/generators/epi_cas/migration_generator.rb",
    "lib/generators/epi_cas/templates/epi_cas_settings.yml",
    "lib/generators/epi_cas/templates/ldap.yml",
    "lib/generators/epi_cas/templates/migration.rb",
    "spec/fast_spec_helper.rb",
    "spec/lib/epi_cas/devise_helper_spec.rb",
    "spec/lib/epi_cas/ldap_authenticator_spec.rb",
    "spec/lib/epi_cas/ldap_info_spec.rb",
    "spec/lib/epi_cas/ticket_authenticator_spec.rb",
    "spec/lib/epi_cas/verifier_spec.rb",
    "spec/lib/epi_cas/whitelist_checker_spec.rb",
    "spec/lib/generators/epi_cas/install_generator_spec.rb",
    "spec/lib/generators/epi_cas/migration_generator_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/ant-nettleship/epi_cas".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.3".freeze
  s.summary = "A gem for adding CAS authentication to your Rails applications.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<settingslogic>.freeze, [">= 2.0.9"])
      s.add_runtime_dependency(%q<sheffield_ldap_lookup>.freeze, [">= 0.0.4"])
      s.add_runtime_dependency(%q<devise>.freeze, [">= 3.2.0"])
      s.add_runtime_dependency(%q<devise_cas_authenticatable>.freeze, [">= 1.3.5"])
      s.add_runtime_dependency(%q<devise_ldap_authenticatable>.freeze, [">= 0.8.3"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 0"])
      s.add_dependency(%q<settingslogic>.freeze, [">= 2.0.9"])
      s.add_dependency(%q<sheffield_ldap_lookup>.freeze, [">= 0.0.4"])
      s.add_dependency(%q<devise>.freeze, [">= 3.2.0"])
      s.add_dependency(%q<devise_cas_authenticatable>.freeze, [">= 1.3.5"])
      s.add_dependency(%q<devise_ldap_authenticatable>.freeze, [">= 0.8.3"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<byebug>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<settingslogic>.freeze, [">= 2.0.9"])
    s.add_dependency(%q<sheffield_ldap_lookup>.freeze, [">= 0.0.4"])
    s.add_dependency(%q<devise>.freeze, [">= 3.2.0"])
    s.add_dependency(%q<devise_cas_authenticatable>.freeze, [">= 1.3.5"])
    s.add_dependency(%q<devise_ldap_authenticatable>.freeze, [">= 0.8.3"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
  end
end
