class Order < ApplicationRecord
  belongs_to :customer
  has_many :books, through: :order_books
  validates :status, presence: true
end
