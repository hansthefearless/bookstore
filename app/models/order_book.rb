class OrderBook < ApplicationRecord
  belongs_to :book
  belongs_to :order
  validates :copies, presence: true
  validates :copies, numericality: { only_integer: true }
end
