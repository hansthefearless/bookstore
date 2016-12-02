class Customer < ApplicationRecord
   validates :login, uniqueness: true
end
