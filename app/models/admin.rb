class Admin < ApplicationRecord
   validates :login, uniqueness: true
   validates :login, :name, :password, presence: true
end
