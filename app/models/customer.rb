class Customer < ApplicationRecord
   validates :login, uniqueness: true
   self.primary_key = 'login'
   validates :login, uniqueness: true
   has_many :orders
   has_many :opinions
   has_many :ratings
end
