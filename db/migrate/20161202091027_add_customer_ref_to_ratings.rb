class AddCustomerRefToRatings < ActiveRecord::Migration[5.0]
  def change
    add_reference :ratings, :customer, foreign_key: true
  end
end
