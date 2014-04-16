require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'epi_cas/user_authentications/verifier'

describe EpiCas::UserAuthentications::Verifier do
  subject { EpiCas::UserAuthentications::Verifier.new('test_user') }
  
  describe '#find_and_verify_and_update_user' do
    let(:user_class) { double }
    describe 'The type of user is allowed to log in' do
      before { subject.stub(allow_authentication?: true) }
      
      it "finds the user by username" do
        subject.stub(ldap_info: double(uid: 'test_user'))
        user_class.should_receive(:find_by_username).with('test_user').and_return(double)
        subject.find_and_verify_and_update_user(user_class)
      end
      
      it "finds the user by email if a user with the given username" do
        subject.stub(ldap_info: double(uid: 'test_user', mail: 'test@user.com'))
        user_class.stub(find_by_username: nil)
        user_class.should_receive(:find_by_email).with('test@user.com').and_return(double)
        subject.find_and_verify_and_update_user(user_class)
      end
      
      it "updates the LDAP info of the user if a user can be found" do
        subject.stub(ldap_info: double(uid: 'test_user', attributes: {sn: 'User', givenname: 'Test'}))
        user = double
        user_class.stub(find_by_username: user)
        user.should_receive(:update_ldap_info).with({sn: 'User', givenname: 'Test'})
        subject.find_and_verify_and_update_user(user_class)
      end
    end
    
    describe 'The type of user is not allowed to log in' do
      before { subject.stub(allow_authentication?: false) }
      
      it "returns a nil value" do
        subject.find_and_verify_and_update_user(user_class).should be_nil
      end
    end
  end
  
  describe '#verify_and_build_new_user' do
    let(:user_class) { double }
    describe 'The type of user is allowed to log in and allowed to be added to system automatically' do
      before { subject.stub(allow_authentication?: true, ldap_info: double(attributes: {sn: 'User', givenname: 'Test'}), whitelist_checker: double(allow_creation?: true)) }
      
      it "build a new user" do
        user_class.should_receive(:new).with({sn: 'User', givenname: 'Test'}).and_return(double)
        subject.verify_and_build_new_user(user_class)
      end
      
      it "updates the LDAP info of the user" do
        user = double
        user_class.stub(new: user)
        user.should_receive(:generate_attributes_from_ldap_info)
        subject.verify_and_build_new_user(user_class)
      end
    end
    
    describe 'The type of user is not allowed to log in' do
      before { subject.stub(allow_authentication?: false) }
      
      it "returns a nil value" do
        subject.find_and_verify_and_update_user(user_class).should be_nil
      end
    end
  end
end