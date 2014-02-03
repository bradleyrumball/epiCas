require 'spec_helper'
require 'generator_spec'
require 'generators/epi_cas/install_generator'

describe EpiCas::InstallGenerator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(user)
  
  before(:all) do
    prepare_destination
    mkdir_p(File.join(destination_root, 'app', 'models'))
    mkdir_p(File.join(destination_root, 'config'))
    
    File.open(File.join(destination_root, 'app', 'models', 'user.rb'), 'w') do |file|
      file.write <<-RUBY
        class User < ActiveRecord::Base
          devise :database_authenticatable
        end
      RUBY
    end
    
    File.open(File.join(destination_root, 'config', 'routes.rb'), 'w')
    run_generator
  end
  
  # it "throws an error if the user model does not exist" do
  #   
  # end
  
  it "creates the initializer file" do
    assert_file "config/initializers/epi_cas.rb", /# Use this initializer to configure EpiCas for your app/
  end
  
end