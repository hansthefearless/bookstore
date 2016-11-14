class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :ISBN
      t.string :title
      t.string :authors
      t.integer :copies
      t.string :subject
      t.integer :year
      t.integer :price
      t.string :publisher
      t.string :keywords
      t.string :format

      t.timestamps
    end
  end
end
