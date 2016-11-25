require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'epi_cas/ldap_authenticator'

describe EpiCas::LdapAuthenticator do
  subject { EpiCas::LdapAuthenticator.new(attributes) }

  context "username not present in attributes" do
    let(:attributes) { {} }
    it "does nothing and returns nil" do
      expect(subject.authenticate_ldap).to be_nil
    end
  end

  context "username present in attributes" do
    let(:attributes) { {username: 'brian'} }

    it "verifies the user" do
      expect(subject).to receive(:verify_user)
      subject.authenticate_ldap
    end
  end

  describe '#verify_user' do
    let(:attributes) { {username: 'brian', password: '123'} }
    let(:verifier) { double }

    before { allow(subject).to receive(:verifier) { verifier } }

    context "valid password" do
      let(:user) { double changed?: false, valid_ldap_authentication?: true }
      before { allow(verifier).to receive(:find_and_verify_and_update_user){ user } }

      it "finds the existing user" do
        expect(subject.send(:verify_user)).to eq user
      end

      it "builds a new user if one does not exist" do
        allow(verifier).to receive(:verify_and_build_new_user){ user }

        expect(subject.send(:verify_user)).to eq user
      end

      it "updates the user" do
        allow(user).to receive(:changed?){ true }
        expect(user).to receive(:save)

        subject.send(:verify_user)
      end
    end

    context "invalid password" do
      let(:user) { double changed?: false, valid_ldap_authentication?: false }
      before { allow(verifier).to receive(:find_and_verify_and_update_user){ user } }

      it "returns nil" do
        expect(subject.send(:verify_user)).to be nil
      end
    end

  end

end
