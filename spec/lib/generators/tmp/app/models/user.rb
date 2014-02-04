class User < ActiveRecord::Base
extend EpiCas::DeviseHelper  devise :"#{auth_method}_authenticatable"
end
