class AddLdapInformationTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :uid, :string
    add_column :<%= table_name %>, :mail, :string
    add_column :<%= table_name %>, :ou, :string
    add_column :<%= table_name %>, :dn, :string
    add_column :<%= table_name %>, :sn, :string
    add_column :<%= table_name %>, :givenname, :string
  end
end