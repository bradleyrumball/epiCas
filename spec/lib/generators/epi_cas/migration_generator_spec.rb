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
    assert_migration 'db/migrate/add_ldap_info_to_users.rb' do |content|
      content.should include 'User.reset_column_information' 
      
      content.should include 'add_column :users, :uid, :string'  
      content.should include 'add_column :users, :mail, :string'
      content.should include 'add_column :users, :ou, :string'
      content.should include 'add_column :users, :dn, :string'
      content.should include 'add_column :users, :sn, :string'
      content.should include 'add_column :users, :givenname, :string'
    end      
  end
end