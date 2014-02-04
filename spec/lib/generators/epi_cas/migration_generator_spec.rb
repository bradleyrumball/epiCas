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
  
  it "does something" do
    
  end
end