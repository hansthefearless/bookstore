class CreateOrderBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :order_books do |t|
      t.belongs_to :order, index: true
      t.belongs_to :book, index: true
      t.integer :copies

      t.timestamps
    end
  end
end
