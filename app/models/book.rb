class Book < ApplicationRecord
   validates :ISBN, uniqueness: true
end
