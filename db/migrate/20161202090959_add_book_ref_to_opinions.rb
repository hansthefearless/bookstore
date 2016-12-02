class AddBookRefToOpinions < ActiveRecord::Migration[5.0]
  def change
    add_reference :opinions, :book, foreign_key: true
  end
end
