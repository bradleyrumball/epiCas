module EpiCas
  
  class << self
    attr_accessor :configuration
  end
  
  # Allow configuration via config/initializers/epi_cas.rb for example:
  # EpiCas.configue do |config| 
  #   config.application_title = 'My Lovely App'
  # end
  def self.configure
    self.configuration ||= Configuation.new
    yield configuration
  end
  
  class Configuation
    attr_accessor :application_title
    attr_accessor :cas_title
    attr_accessor :cas_base_url
    attr_accessor :cas_logout_url
  
    def initialize
      @application_title = "Application"
      @cas_title         = "Online Services"
      @cas_base_url      = 'https://some.url/cas'
      @cas_logout_url    = 'https://some.url/cas/logout'
    end
  end
  
end