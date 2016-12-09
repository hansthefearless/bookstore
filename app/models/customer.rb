class Customer < ApplicationRecord
   validates :login, uniqueness: true
   validates :login, :name, :password, :CCN, :phone, :address, presence: true
   validates :phone, numericality: { only_integer: true }
   has_many :orders
   has_many :opinions
   has_many :ratings
end
