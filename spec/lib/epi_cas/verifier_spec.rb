require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'epi_cas/verifier'

describe EpiCas::Verifier do
  let(:user_class) { double }
  subject { EpiCas::Verifier.new('test_user', user_class) }

  describe '#find_and_verify_and_update_user' do
    describe 'The type of user is allowed to log in' do
      before { allow(subject).to receive(:allow_authentication?){ true } }

      it "finds the user by username" do
        allow(subject).to receive(:ldap_info){ double(uid: 'test_user') }
        expect(user_class).to receive(:find_by_username).with('test_user').and_return(double)
        subject.find_and_verify_and_update_user
      end

      it "updates the LDAP info of the user if a user can be found" do
        allow(subject).to receive(:ldap_info){ double(uid: 'test_user', attributes: {sn: 'User', givenname: 'Test'}) }
        user = double
        allow(user_class).to receive(:find_by_username){ user }

        expect(user).to receive(:update_ldap_info).with({sn: 'User', givenname: 'Test'})
        subject.find_and_verify_and_update_user
      end
    end

    describe 'The type of user is not allowed to log in' do
      before { allow(subject).to receive(:allow_authentication?){ false } }

      it "returns a nil value" do
        expect(subject.find_and_verify_and_update_user).to be_nil
      end
    end
  end

  describe '#verify_and_build_new_user' do
    describe 'The type of user is allowed to log in and allowed to be added to system automatically' do
      before do
        allow(subject).to receive(:allow_authentication?){ true }
        allow(subject).to receive(:ldap_info){ double(attributes: {sn: 'User', givenname: 'Test'}) }
        allow(subject).to receive(:whitelist_checker){  double(allow_creation?: true) }
      end

      it "build a new user" do
        user = double
        expect(user_class).to receive(:new){ user }
        expect(user).to receive(:update_ldap_info).with({sn: 'User', givenname: 'Test'})
        subject.verify_and_build_new_user
      end

      it "updates the LDAP info of the user" do
        user = double(update_ldap_info: nil)
        expect(user_class).to receive(:new){ user }
        expect(user).to receive(:generate_attributes_from_ldap_info)
        subject.verify_and_build_new_user
      end
    end

    describe 'The type of user is not allowed to log in' do
      before { allow(subject).to receive(:allow_authentication?){ false } }

      it "returns a nil value" do
        expect(subject.find_and_verify_and_update_user).to be_nil
      end
    end
  end
end
