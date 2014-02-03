        class User < ActiveRecord::Base
extend EpiCas::DeviseHelper          devise :database_authenticatable
        end
