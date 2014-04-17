class AddLdapInfoAndCleanUp<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    
    <%= class_name %>.reset_column_information
    existing_columns = <%= class_name %>.column_names
    
    unless existing_columns.include?('username')
      add_column :<%= table_name %>, :username, :string 
      add_index :<%= table_name %>, :username
    end
    
    if existing_columns.include?('email')
      # We don't want the unique index on email which is added by devise by default
      remove_index :<%= table_name %>, :email
    else
      add_column :<%= table_name %>, :email, :string 
    end
    add_index :<%= table_name %>, :email
    
    # Cache the ldap attributes
    missing_columns = %w(uid mail ou dn sn givenname) - existing_columns
    missing_columns.each do |column_name|
      add_column :<%= table_name %>, column_name, :string
    end
    
    # Remove devise fields we don't need
    unnecessary_columns = %w(reset_password_token reset_password_sent_at remember_created_at encrypted_password) & existing_columns
    unnecessary_columns.each do |column_name|
      remove_column :<%= table_name %>, column_name
    end
  end
end