require 'rails/generators/active_record'

module EpiCas
  class MigrationGenerator < ActiveRecord::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
      
    def add_ldap_info_to_model
      migration_template "migration.rb", "db/migrate/add_ldap_info_to_#{table_name}.rb"
    end
  end
end