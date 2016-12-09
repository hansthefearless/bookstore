class CreateOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :opinions do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :book, index: true
      t.integer :score
      t.text :text

      t.timestamps
    end
  end
end
