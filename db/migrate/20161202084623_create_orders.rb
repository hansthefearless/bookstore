class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, index: true
      t.string :status, null:false

      t.timestamps
    end
  end
end
