class AddLdapInformationTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    <%= class_name %>.reset_column_information
    
    unless <%= class_name %>.column_names.include?('username')
      add_column :<%= table_name %>, :username, :string 
      add_index :<%= table_name %>, :username
    end
    
    unless <%= class_name %>.column_names.include?('email')
      add_column :<%= table_name %>, :email, :string 
      add_index :<%= table_name %>, :email
    end
    
    add_column :<%= table_name %>, :uid, :string
    add_column :<%= table_name %>, :mail, :string
    add_column :<%= table_name %>, :ou, :string
    add_column :<%= table_name %>, :dn, :string
    add_column :<%= table_name %>, :sn, :string
    add_column :<%= table_name %>, :givenname, :string
  end
end