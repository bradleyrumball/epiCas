# epiCAS
---

### Description
A gem for adding CAS authentication to your Rails applications.

* Adds Devise to your app and installs it (if it's not there already)
* Provides a generator to create a model (if not already there) and adds the appropriate migrations, routes, and views

### Prerequisites
A Rails app (3.2 or above). The gem will install Devise et al for you.

### Usage
1. Remove the ```config/initializers/devise.rb``` file if you have one already.

2. Add the devise ldap gem to your Gemfile (temporary until it gets put on rubygems):

    ```
    gem 'devise_ldap_authenticatable', github: 'cschiewek/devise_ldap_authenticatable'
    ```

3. Add the gem to your Gemfile:

    **Genesys/Hut/Crossover students:**
    ```
    gem "epi_cas", git: "git@git.genesys-solutions.org.uk:gems/epi_cas.git"
    ```

    **epiGenesys staff:**
    ```
    gem "epi_cas", git: "git@git.epigenesys.org.uk:epigenesys/epi-cas.git"
    ```

4. Install the new gems:

    ```
    bundle install
    ```

5. Run the install generator passing in the model name:

    ```
    bundle exec rails g epi_cas:install ModelName
    ```

    **Note:**
    If the project has already been Devise enabled (as the Rails template has), you can add `--no-devise-install` to disable re-running the `devise:install` task.
    
6. Migrate the database:

    ```
    bundle exec rake db:migrate
    ```
    
### Configuration
The configuration file is `config/epi_cas_settings.yml`.

You should change the titles and urls appropriately. You can also specify the groups of users allowed access to your system.

### Customisation
You can override the following methods in your model to do any additional processing such as settings departments:

    def update_ldap_info(ldap_info)
      # etc.
    end
    
    def generate_attributes_from_ldap_info
      # etc.
    end
 
See [devise_helper.rb](lib/epi_cas/devise_helper.rb).

You can also override any of the views, have a browse through the source if you need to do this.