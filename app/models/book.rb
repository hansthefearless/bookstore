class Book < ApplicationRecord
   self.primary_key = 'ISBN'
   validates :ISBN, uniqueness: true
   has_many :opinions
   has_many :orders, through: :order_books
end
