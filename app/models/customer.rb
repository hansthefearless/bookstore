class Customer < ApplicationRecord
   self.primary_key = 'login'
   validates :login, uniqueness: true
end
