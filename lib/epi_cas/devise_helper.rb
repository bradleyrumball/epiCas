module EpiCas::DeviseHelper
  
  def auth_method 
    EpiCas::Settings.epi_cas['auth_method'].to_s.downcase
  end
  
end