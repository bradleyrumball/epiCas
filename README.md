# epiCAS
---

### Description
A gem for adding CAS authentication to your Rails applications.

* Adds devise to your app and installs (if it's not there already)
* Provides a generator to create a model (if not already there) add the appropriate migrations, routes, and views  

### Prerequisites
A rails app (3.2 or above). The gem will install devise et al for you.


### Usage
Add the gem to your Gemfile and bundle:

    gem "epi_cas", git: "git@git.epigenesys.org.uk:epigenesys/epi-cas.git"
	
Run the install generator passing in the model name:

    bundle exec rails g epi_cas:install ModelName
    
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