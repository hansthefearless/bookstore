class Order < ApplicationRecord
<<<<<<< HEAD
=======
  belongs_to :customer
  has_many :books, through: :order_books
>>>>>>> 66e0515b1b48d2211713ccc48cb4c815b2dfee44
end
