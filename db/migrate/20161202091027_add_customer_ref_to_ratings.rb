class AddCustomerRefToRatings < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :ratings, :customer, name: :customer_id
  end
end
