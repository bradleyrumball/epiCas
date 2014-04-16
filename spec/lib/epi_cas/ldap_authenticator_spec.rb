require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'epi_cas/ldap_authenticator'

describe EpiCas::LdapAuthenticator do
  subject { EpiCas::LdapAuthenticator.new(attributes) }
  
  context "username not present in attributes" do
    let(:attributes) { {} }
    it "does nothing and returns nil" do
      subject.authenticate_ldap.should be_nil
    end
  end
  
  context "username present in attributes" do
    let(:attributes) { {username: 'brian'} }
    
    it "verifies the user" do
      subject.should_receive(:verify_user)
      subject.authenticate_ldap
    end
  end
  
  describe '#verify_user' do
    let(:attributes) { {username: 'brian', password: '123'} }
    let(:verifier) { double }

    before { subject.stub(verifier: verifier) }
    
    context "valid password" do
      let(:user) { double changed?: false, valid_ldap_authentication?: true }
      it "finds the existing user" do
        verifier.stub(find_and_verify_and_update_user: user)
        subject.send(:verify_user).should == user
      end

      it "builds a new user if one does not exist" do
        verifier.stub(find_and_verify_and_update_user: nil, verify_and_build_new_user: user)
        subject.send(:verify_user).should == user
      end

      it "updates the user" do
        verifier.stub(find_and_verify_and_update_user: user)
        user.stub(changed?: true)
        user.should_receive(:save)
        subject.send(:verify_user)
      end
    end
    
    context "invalid password" do
      let(:user) { double changed?: false, valid_ldap_authentication?: false }
      it "returns nil" do
        verifier.stub(find_and_verify_and_update_user: user)
        subject.send(:verify_user).should be nil
      end
      
      
    end
    
  end
  
end