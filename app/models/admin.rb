class Admin < ApplicationRecord
   validates :login, uniqueness: true
end
