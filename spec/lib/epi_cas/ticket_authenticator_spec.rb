require 'fast_spec_helper'
require 'epi_cas/ticket_authenticator'

describe EpiCas::TicketAuthenticator do
  subject { EpiCas::TicketAuthenticator.new(ticket, double) }
  
  context "ticket not validated" do
    let(:ticket) { double has_been_validated?: false }
    it "tries 3 times to validate the cas ticket then returns nil" do
      subject.should_receive(:validate_ticket).exactly(3).times.and_raise(Errno::ECONNRESET)
      subject.authenticate_ticket.should be_nil
    end
  end
  
  context "ticket has been validated" do
    let(:ticket) { double has_been_validated?: true, is_valid?: ticket_valid? }
    
    context "ticket is valid" do
      let(:ticket_valid?) { true }
      it "returns the verified user" do
        user = double
        subject.stub(verify_user: user)
        subject.authenticate_ticket.should == user
      end
    end
    
    context "ticket is not valid" do
      let(:ticket_valid?) { false }
      it "returns nil" do
        subject.authenticate_ticket.should be_nil
      end
    end
  end
  
  describe '#verify_user' do
    let(:ticket) { double has_been_validated?: true, is_valid?: true }
    let(:verifier) { double }
    let(:user) { double changed?: false }
    before { subject.stub(verifier: verifier) }
    
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
  
end