class AddLdapInformationToUsers < ActiveRecord::Migration
  def change
    User.reset_column_information
    
    unless User.column_names.include?('username')
      add_column :users, :username, :string 
      add_index :users, :username
    end
    
    unless User.column_names.include?('email')
      add_column :users, :email, :string 
      add_index :users, :email
    end
    
    add_column :users, :uid, :string
    add_column :users, :mail, :string
    add_column :users, :ou, :string
    add_column :users, :dn, :string
    add_column :users, :sn, :string
    add_column :users, :givenname, :string
  end
end