class Book < ApplicationRecord
   validates :ISBN, uniqueness: true
   has_many :opinions
   has_many :orders, through: :order_books
   validates :format, inclusion: {in: %w(Softcover Hardcover) }
   validates :title, :authors, :publisher, :subject, :keywords, :ISBN, :copies, :year, :price, :format, presence: true
   validates :copies, :year, :price, numericality: { only_integer: true }
   validates :copies, :price, numericality: { greater_than: -1 }
end
