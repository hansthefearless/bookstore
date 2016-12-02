class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :login, null:false
      t.string :password, null:false
      t.string :name, null:false
      t.integer :phone, null:false
      t.string :address, null:false
      t.string :CCN, null:false

      t.timestamps
    end
  end
end
