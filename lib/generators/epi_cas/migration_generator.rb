require 'rails/generators/active_record'

module EpiCas
  class MigrationGenerator < ActiveRecord::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add_ldap_info_and_clean_up_model
      @migration_version = "[#{ActiveRecord::Migration.current_version}]" if ActiveRecord::Migration.respond_to?(:current_version)
      migration_template "migration.rb", "db/migrate/add_ldap_info_and_clean_up_#{table_name}.rb"
    end
  end
end
