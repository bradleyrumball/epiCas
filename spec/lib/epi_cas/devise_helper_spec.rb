require 'fast_spec_helper'
require 'epi_cas/devise_helper'

describe EpiCas::DeviseHelper do

  class EpiCas::Settings
    def self.[] arg
    end
  end

  class MockUser
    def self.devise *args      
    end
    include EpiCas::DeviseHelper
    attr_accessor :uid
    attr_accessor :mail
    attr_accessor :username
    attr_accessor :email
    def assign_attributes(hash)
      hash.each { |k, v| send("#{k}=", v) }
    end
  end
  
  subject { MockUser.new }
  
  describe '#update_ldap_info(ldap_info)' do
    it "assigns the ldap attributes to the model" do
      subject.update_ldap_info(uid: 'hi', mail: 'hello')
      subject.uid.should  == 'hi'
      subject.mail.should == 'hello'
    end
  end
  
  describe '#generate_attributes_from_ldap_info' do
    it "generates any additional attrubutes from the ldap attributes" do
      subject.stub uid:  'example_uid'
      subject.stub mail: 'example.mail@epigenesys.co.uk'
      subject.generate_attributes_from_ldap_info
      subject.username.should == 'example_uid'
      subject.email.should    == 'example.mail@epigenesys.co.uk'
    end
  end
  
  describe '.authenticate_with_cas_ticket' do
    it "hands the ticket to the the ticket authenticator" do
      ticket = double
      authenticator = double
      authenticator.should_receive(:new).with(ticket).and_return(double(authenticate_ticket: nil))
      subject.class.authenticate_with_cas_ticket(ticket, authenticator)
    end
  end
  
  describe '.find_for_ldap_authentication' do
    it "hands the attributes to the the ldap authenticator" do
      attributes    = double
      authenticator = double
      authenticator.should_receive(:new).with(attributes).and_return(double(authenticate_ldap: nil))
      subject.class.find_for_ldap_authentication(attributes, authenticator)
    end
  end
  
end