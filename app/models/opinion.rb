class Opinion < ApplicationRecord
  belongs_to :customer
  belongs_to :book
  has_many :ratings
  validates :score, presence: true
  validates :score, numericality: { only_integer: true }
  validates :book_id, uniqueness: { scope: :customer_id,
  message: "You have already created an opinion for this book!"}
end
