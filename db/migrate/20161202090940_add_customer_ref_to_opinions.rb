class AddCustomerRefToOpinions < ActiveRecord::Migration[5.0]
  def change
    add_reference :opinions, :customer, foreign_key: true
  end
end
