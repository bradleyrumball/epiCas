require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'epi_cas/whitelist_checker'

describe EpiCas::WhitelistChecker do
  subject { EpiCas::WhitelistChecker.new(raw_dn, 'username') }

  describe 'private methods' do
    let(:raw_dn) { '' }

    describe '#groups_allowed_to_log_in' do
      it "converts the user group to symbols" do
        allow(subject).to receive(:settings).with('groups_allowed_to_log_in').and_return(['staff', 'external'])
        expect(subject.send(:groups_allowed_to_log_in)).to eq [:staff, :external]
      end
    end

    describe '#groups_allowed_to_be_created' do
      it "converts the user group to symbols" do
        allow(subject).to receive(:settings).with('groups_allowed_to_be_created').and_return(['staff', 'external'])
        expect(subject.send(:groups_allowed_to_be_created)).to eq [:staff, :external]
      end
    end

    describe '#username_whitelisted?' do
      it "returns true if the username is whitelisted" do
        allow(subject).to receive(:settings).with('username_whitelist').and_return(['username'])
        expect(subject.send(:username_whitelisted?)).to be_truthy
      end

      it "returns false if the username is not whitelisted" do
        allow(subject).to receive(:settings).with('username_whitelist').and_return(['another_username'])
        expect(subject.send(:username_whitelisted?)).to be_falsey
      end
    end

  end

  context "username whitelisted" do
    let(:raw_dn) { "uid=testuser,ou=Taught,ou=Postgraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk"}
    before { allow(subject).to receive(:username_whitelisted?){ true } }

    specify 'User can log in' do
      expect(subject.allow_authentication?).to be_truthy
    end

    specify 'User account can be automatically created if not in the system already' do
      expect(subject.allow_creation?).to be_truthy
    end
  end

  context "username not in whitelist and staff / externals can log in" do

    before do
      groups = [:staff, :staff_honorary, :staff_visiting, :external]
      allow(subject).to receive(:username_whitelisted?){ false }
      allow(subject).to receive(:settings).with('groups_allowed_to_log_in').and_return(groups)
      allow(subject).to receive(:settings).with('groups_allowed_to_be_created').and_return(groups)
      allow(subject).to receive(:settings).with('departments_allowed_to_log_in')
      allow(subject).to receive(:settings).with('departments_allowed_to_be_created')
    end
    context 'Staff' do
      let(:raw_dn) { "uid=testuser,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'Staff can log in' do
        expect(subject.allow_authentication?).to be_truthy
      end

      specify 'Staff account can be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_truthy
      end
    end

    context 'Honorary Staff' do
      let(:raw_dn) { "uid=testuser,ou=Honorary,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'Honorary Staff can log in' do
        expect(subject.allow_authentication?).to be_truthy
      end

      specify 'Honorary Staff account can be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_truthy
      end
    end

    context 'Visiting Staff' do
      let(:raw_dn) { "uid=testuser,ou=Visiting,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'Visiting Staff can log in' do
        expect(subject.allow_authentication?).to be_truthy
      end

      specify 'Visiting Staff account can be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_truthy
      end
    end

    context 'PGR Student' do
      let(:raw_dn) { "uid=testuser,ou=Research,ou=Postgraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'PGR Student cannot log in' do
        expect(subject.allow_authentication?).to be_falsey
      end

      specify 'PGR Student account cannot be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_falsey
      end
    end

    context 'PGT Student' do
      let(:raw_dn) { "uid=testuser,ou=Taught,ou=Postgraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'PGT Student cannot log in' do
        expect(subject.allow_authentication?).to be_falsey
      end

      specify 'PGT Student account cannot be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_falsey
      end
    end

    context 'Undergrade Student' do
      let(:raw_dn) { "uid=testuser,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      specify 'Undergrade Student cannot log in' do
        expect(subject.allow_authentication?).to be_falsey
      end

      specify 'Undergrade Student Student account cannot be automatically created if not in the system already' do
        expect(subject.allow_creation?).to be_falsey
      end
    end
  end

end
