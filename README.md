# epiCAS
---

### Description
A gem for adding CAS authentication to your Rails applications.

* Adds Devise to your app and installs it (if it's not there already)
* Provides a generator to create a model (if not already there) and adds the appropriate migrations, routes, and views

### Prerequisites

* A Rails application (3.2 or above)

### Usage

1. Set up a project using the provided Rails template.

2. Add the gem to your Gemfile:

    **Computer Science students:**
    ```
    gem "epi_cas", git: "git@git.shefcompsci.org.uk:gems/epi_cas.git"
    ```

    **epiGenesys staff:**
    ```
    gem "epi_cas", git: "git@git.epigenesys.org.uk:epigenesys/epi-cas.git"
    ```

3. Install the new gems:

    ```
    bundle install
    ```

4. Run the install generator, passing in the relevant model name (usually User):

    ```
    bundle exec rails g epi_cas:install ModelName
    ```

5. Migrate the database:

    ```
    bundle exec rails db:migrate
    ```

### Configuration
The configuration file is `config/epi_cas_settings.yml`.

You should change the titles and URLs as appropriate. You can also specify the groups of users allowed access to your system.

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
