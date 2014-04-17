# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: epi_cas 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "epi_cas"
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ant Nettleship", "Shuo Chen"]
  s.date = "2014-04-17"
  s.description = "dds devise to your app and installs (if it's not there already). Provides a generator to create a model (if not already there) add the appropriate migrations, routes, and views."
  s.email = "a.nettleship@epigenesys.co.uk"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/controllers/epi_cas/sessions_controller.rb",
    "app/controllers/epi_cas_controller.rb",
    "app/views/epi_cas/sessions/app_log_out.html.haml",
    "config/initializers/devise.rb",
    "config/locales/devise.en.yml",
    "epi_cas.gemspec",
    "lib/epi_cas.rb",
    "lib/epi_cas/devise_helper.rb",
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
    "lib/generators/epi_cas/templates/settings.rb",
    "spec/fast_spec_helper.rb",
    "spec/lib/epi_cas/devise_helper_spec.rb",
    "spec/lib/epi_cas/ldap_authenticator_spec.rb",
    "spec/lib/epi_cas/ldap_info_spec.rb",
    "spec/lib/epi_cas/ticket_authenticator_spec.rb",
    "spec/lib/epi_cas/verifier_spec.rb",
    "spec/lib/epi_cas/whitelist_checker_spec.rb",
    "spec/lib/generators/epi_cas/install_generator_spec.rb",
    "spec/lib/generators/epi_cas/migration_generator_spec.rb",
    "spec/lib/generators/tmp/db/migrate/20140417130400_add_ldap_info_to_users.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/ant-nettleship/epi_cas"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "A gem for adding CAS authentication to your Rails applications."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<settingslogic>, [">= 2.0.9"])
      s.add_runtime_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
      s.add_runtime_dependency(%q<devise>, [">= 3.2.0"])
      s.add_runtime_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
      s.add_runtime_dependency(%q<devise_ldap_authenticatable>, ["~> 0.8.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<settingslogic>, [">= 2.0.9"])
      s.add_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
      s.add_dependency(%q<devise>, [">= 3.2.0"])
      s.add_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
      s.add_dependency(%q<devise_ldap_authenticatable>, ["~> 0.8.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<debugger>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<settingslogic>, [">= 2.0.9"])
    s.add_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
    s.add_dependency(%q<devise>, [">= 3.2.0"])
    s.add_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
    s.add_dependency(%q<devise_ldap_authenticatable>, ["~> 0.8.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<debugger>, [">= 0"])
  end
end

