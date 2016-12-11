class Rating < ApplicationRecord
  belongs_to :customer
  belongs_to :opinion
  validates :usefulness, presence: true
  validates :usefulness, numericality: { only_integer: true }
  validates :opinion_id, uniqueness: { scope: :customer_id,
  message: "Feedback already rated"}
end
