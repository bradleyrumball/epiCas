require 'fast_spec_helper'
require 'epi_cas/ticket_authenticator'

describe EpiCas::TicketAuthenticator do
  subject { EpiCas::TicketAuthenticator.new(ticket, double) }

  context "ticket not validated" do
    let(:ticket) { double has_been_validated?: false }
    it "tries 3 times to validate the cas ticket then returns nil" do
      allow(subject).to receive(:validate_ticket).exactly(3).times.and_raise(Errno::ECONNRESET)
      
      expect(subject.authenticate_ticket).to be_nil
    end
  end

  context "ticket has been validated" do
    let(:ticket) { double has_been_validated?: true, is_valid?: ticket_valid? }

    context "ticket is valid" do
      let(:ticket_valid?) { true }
      it "returns the verified user" do
        user = double
        allow(subject).to receive(:verify_user){ user }

        expect(subject.authenticate_ticket).to eq user
      end
    end

    context "ticket is not valid" do
      let(:ticket_valid?) { false }
      it "returns nil" do
        expect(subject.authenticate_ticket).to be_nil
      end
    end
  end

  describe '#verify_user' do
    let(:ticket) { double has_been_validated?: true, is_valid?: true }
    let(:verifier) { double }
    let(:user) { double changed?: false }
    before { allow(subject).to receive(:verifier){ verifier } }

    it "finds the existing user" do
      allow(verifier).to receive(:find_and_verify_and_update_user){ user }

      expect(subject.send(:verify_user)).to eq user
    end

    it "builds a new user if one does not exist" do
      allow(verifier).to receive(:find_and_verify_and_update_user){ nil }
      allow(verifier).to receive(:verify_and_build_new_user){ user }

      expect(subject.send(:verify_user)).to eq user
    end

    it "updates the user" do
      allow(verifier).to receive(:find_and_verify_and_update_user){ user }
      allow(user).to receive(:changed?){ true }

      expect(user).to receive(:save)
      subject.send(:verify_user)
    end
  end

end
