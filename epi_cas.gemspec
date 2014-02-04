# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "epi_cas"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ant Nettleship"]
  s.date = "2014-02-04"
  s.description = "TODO: longer description of your gem"
  s.email = "a.nettleship@epigenesys.co.uk"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/epi_cas/sessions_controller.rb",
    "app/controllers/epi_cas_controller.rb",
    "app/views/epi_cas/sessions/app_log_out.html.haml",
    "lib/epi_cas.rb",
    "lib/generators/epi_cas/install_generator.rb",
    "spec/epi_cas_spec.rb",
    "spec/lib/generators/epi_cas/install_generator_spec.rb",
    "spec/lib/generators/tmp/app/models/user.rb",
    "spec/lib/generators/tmp/config/routes.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/ant-nettleship/epi_cas"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "TODO: one-line summary of your gem"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<settingslogic>, [">= 2.0.9"])
      s.add_runtime_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
      s.add_runtime_dependency(%q<devise>, [">= 3.2.0"])
      s.add_runtime_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<devise_ldap_authenticatable>, [">= 0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<settingslogic>, [">= 2.0.9"])
      s.add_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
      s.add_dependency(%q<devise>, [">= 3.2.0"])
      s.add_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<devise_ldap_authenticatable>, [">= 0"])
      s.add_dependency(%q<debugger>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<settingslogic>, [">= 2.0.9"])
    s.add_dependency(%q<sheffield_ldap_lookup>, [">= 0.0.3"])
    s.add_dependency(%q<devise>, [">= 3.2.0"])
    s.add_dependency(%q<devise_cas_authenticatable>, [">= 1.3.5"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<devise_ldap_authenticatable>, [">= 0"])
    s.add_dependency(%q<debugger>, [">= 0"])
  end
end

