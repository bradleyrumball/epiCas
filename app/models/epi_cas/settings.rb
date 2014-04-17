require 'settingslogic'
module EpiCas
  class Settings < Settingslogic
    source "#{Rails.root}/config/epi_cas_settings.yml"
    namespace Rails.env
  end
end