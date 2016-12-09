class AddRaterToRatings < ActiveRecord::Migration[5.0]
  def change
     add_reference(:ratings, :customer_rated, foreign_key: {to_table: :customers})
  end
end
