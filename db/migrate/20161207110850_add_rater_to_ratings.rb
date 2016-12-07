class AddRaterToRatings < ActiveRecord::Migration[5.0]
  def change
     add_reference(:ratings, :rater, foreign_key: {to_table: :customer})
  end
end
