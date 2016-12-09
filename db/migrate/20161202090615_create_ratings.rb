class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :opinion, index: true
      t.string :usefulness

      t.timestamps
    end
  end
end
