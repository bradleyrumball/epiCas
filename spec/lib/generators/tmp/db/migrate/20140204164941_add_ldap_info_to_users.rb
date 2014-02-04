class AddLdapInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :mail, :string
    add_column :users, :ou, :string
    add_column :users, :dn, :string
    add_column :users, :sn, :string
    add_column :users, :givenname, :string
  end
end