class Book < ApplicationRecord
   self.primary_key = 'ISBN'
   validates :ISBN, uniqueness: true
end
