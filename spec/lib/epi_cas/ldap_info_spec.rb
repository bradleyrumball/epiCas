require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'epi_cas/ldap_info'

describe EpiCas::LdapInfo do
  subject { EpiCas::LdapInfo.new('username', double(find_by_username: double(uid: "abc", givenname: "test", sn: "user", mail: "test@user.com", dn: "dn", ou: "EPG"))) }

  describe '#get_ldap_info' do
    describe 'Getting info from LDAP' do
      it "gets the info from ldap server when a user can be found" do
        allow(subject).to receive(:ldap_finder){ double(lookup: { 'uid' => ['abc'], 'givenname' => ['test'], 'sn' => ['user'], 'mail' => ['test@user.com'], 'dn' => ['dn'], 'ou' => ['EPG'] }) }
        expect(subject.send(:get_ldap_info, double(read_only: false))).to eq ({
          uid: "abc",
          givenname: "test",
          sn: "user",
          mail: "test@user.com",
          dn: "dn",
          ou: "EPG"
        })
      end

      it "returns empty hash if user cannot be found" do
        allow(subject).to receive(:ldap_finder){ double(lookup: { }) }
        expect(subject.send(:get_ldap_info, double(read_only: false))).to eq ({})
      end
    end

    describe 'LDAP server down' do
      before do
        class FakeLdapError < StandardError; end
        ldap_finder = double
        allow(ldap_finder).to receive(:lookup).and_raise(FakeLdapError)
        allow(subject).to receive(:ldap_finder){ ldap_finder }
      end

      it 'uses the existing data in database if LDAP server fails to work' do
        expect(subject).to receive(:get_ldap_info_from_database)
        subject.send(:get_ldap_info, double(read_only: false))
      end

      it "returns empty hash if user does not already exist" do
        expect(subject).to receive(:get_ldap_info_from_database){ {} }
        expect(subject.send(:get_ldap_info, double(read_only: false))).to eq ({})
      end
    end

    describe 'When the system is read only' do
      it 'uses the existing data in database' do
        expect(subject).to receive(:get_ldap_info_from_database)
        subject.send(:get_ldap_info, double(read_only: true))
      end
    end
  end

  describe '#get_ldap_info_from_database' do
    it 'finds the user in database and returns the LDAP information' do
      user_class = double(find_by_username: double(uid: 'abc', givenname: 'test', sn: 'user', mail: 'test@user.com', dn: 'dn', ou: 'EPG'))
      expect(subject.send(:get_ldap_info_from_database, user_class)).to eq ({
        uid: "abc",
        givenname: "test",
        sn: "user",
        mail: "test@user.com",
        dn: "dn",
        ou: "EPG"
      })
    end
  end

end
