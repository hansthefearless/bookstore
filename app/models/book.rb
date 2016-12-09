class Book < ApplicationRecord
   validates :ISBN, uniqueness: true
   has_many :opinions
   has_many :orders, through: :order_books
   validates :title, :authors, :publisher, :subject, :keywords, :ISBN, :copies, :year, :price, :format, presence: true
   validates :copies, :year, numericality: { only_integer: true }
   validates :price, numericality: { only_integer: false }
end
