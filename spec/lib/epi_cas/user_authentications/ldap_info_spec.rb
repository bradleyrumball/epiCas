require 'fast_spec_helper'
require 'active_support/core_ext/object/blank'
require 'epi_cas/user_authentications/ldap_info'

describe EpiCas::UserAuthentications::LdapInfo do
  subject { EpiCas::UserAuthentications::LdapInfo.new('username') }
  
  describe '#get_ldap_info' do
    describe 'Getting info from LDAP' do
      it "gets the info from ldap server when a user can be found" do
        subject.stub(ldap_finder: double(lookup: { 'uid' => ['abc'], 'givenname' => ['test'], 'sn' => ['user'], 'mail' => ['test@user.com'], 'dn' => ['dn'], 'ou' => ['EPG'] }))
        subject.send(:get_ldap_info, double(read_only: false)).should == {
          uid: "abc", 
          givenname: "test", 
          sn: "user", 
          mail: "test@user.com", 
          dn: "dn", 
          ou: "EPG"
        }
      end
      
      it "returns empty hash if user cannot be found" do
        subject.stub(ldap_finder: double(lookup: { }))
        subject.send(:get_ldap_info, double(read_only: false)).should == {}
      end
    end
    
    describe 'LDAP server down' do
      it 'uses the existing data in database if LDAP server fails to work' do
        class FakeLdapError < StandardError; end
        ldap_finder = double
        ldap_finder.stub(:lookup).and_raise(FakeLdapError)
        subject.stub(ldap_finder: ldap_finder)

        subject.should_receive :get_ldap_info_from_database
        subject.send(:get_ldap_info, double(read_only: false))
      end
      
      it "returns empty hash if user does not already exist" do
        subject.stub(ldap_finder: double(lookup: { }))
        subject.send(:get_ldap_info, double(read_only: false)).should == {}
      end
    end

    describe 'When the system is read only' do
      it 'uses the existing data in database' do
        subject.should_receive :get_ldap_info_from_database
        subject.send(:get_ldap_info, double(read_only: true))
      end
    end
  end

  describe '#get_ldap_info_from_database' do
    it 'finds the user in database and returns the LDAP information' do
      user_class = double(find_by_username: double(uid: 'abc', givenname: 'test', sn: 'user', mail: 'test@user.com', dn: 'dn', ou: 'EPG'))
      subject.send(:get_ldap_info_from_database, user_class).should == {
        uid: "abc", 
        givenname: "test", 
        sn: "user", 
        mail: "test@user.com", 
        dn: "dn", 
        ou: "EPG"
      }
    end
  end
  
end