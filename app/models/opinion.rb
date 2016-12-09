class Opinion < ApplicationRecord
  belongs_to :customer
  belongs_to :book
  has_many :ratings
end
