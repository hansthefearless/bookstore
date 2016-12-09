class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :ISBN, null:false
      t.string :title, null:false
      t.string :authors, null:false
      t.integer :copies, null:false
      t.string :subject, null:false
      t.integer :year, null:false
      t.integer :price, null:false
      t.string :publisher, null:false
      t.string :keywords, null:false
      t.string :format, null:false
      t.string :thumbnail

      t.timestamps
    end
  end
end
