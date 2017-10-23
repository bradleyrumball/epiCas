require 'spec_helper'
require 'generator_spec'
require 'generators/epi_cas/migration_generator'

describe EpiCas::MigrationGenerator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(user)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a migration with the fields required for storing ldap attributes" do
    assert_migration 'db/migrate/add_ldap_info_and_clean_up_users.rb' do |content|
      assert_match /ActiveRecord::Migration\[#{ActiveRecord::Migration.current_version}\]/, content
      assert_match /add_index :users, :email/, content
      assert_match /add_column :users, column_name, :string/, content
    end
  end
end
