class Rating < ApplicationRecord
  belongs_to :customer
  belongs_to :opinion
  validates :usefulness, presence: true
  validates :usefulness, numericality: { only_integer: true }
end
