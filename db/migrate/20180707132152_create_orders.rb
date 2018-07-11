class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :meal_id
      t.integer :trip_id
      t.datetime :date
      t.text     :comment

      t.timestamps
    end
  end
end
