require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "EpiCas" do
  
  describe "Configuration" do
    
    before :each do
      EpiCas.configure {} # defaults
    end
    
    describe "application_title" do
      specify "The default is 'Application'" do
        EpiCas.configuration.application_title.should == 'Application'
      end
      
      specify "It can be overridden" do
        EpiCas.configure do |config|
          config.application_title = 'Overridden'
        end
        EpiCas.configuration.application_title.should == 'Overridden'
      end
    end
    
    describe "cas_title" do
      specify "The default is 'Online Services'" do
        EpiCas.configuration.cas_title.should == 'Online Services'
      end
      
      specify "It can be overridden" do
        EpiCas.configure do |config|
          config.cas_title = 'Overridden'
        end
        EpiCas.configuration.cas_title.should == 'Overridden'
      end
    end
    
    describe "cas_base_url" do
      specify "The default is 'https://some.url/cas'" do
        EpiCas.configuration.cas_base_url.should == 'https://some.url/cas'
      end
      
      specify "It can be overridden" do
        EpiCas.configure do |config|
          config.cas_base_url = 'Overridden'
        end
        EpiCas.configuration.cas_base_url.should == 'Overridden'
      end
    end
    
    describe "cas_log_out_url" do
      specify "The default is ''https://some.url/cas/logout''" do
        EpiCas.configuration.cas_log_out_url.should == 'https://some.url/cas/logout'
      end
      
      specify "It can be overridden" do
        EpiCas.configure do |config|
          config.cas_log_out_url = 'Overridden'
        end
        EpiCas.configuration.cas_log_out_url.should == 'Overridden'
      end
    end
    
  end
  
end
