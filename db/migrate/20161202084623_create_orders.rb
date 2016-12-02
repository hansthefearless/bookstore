class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :copies, null:false
      t.string :status, null:false

      t.timestamps
    end
  end
end
