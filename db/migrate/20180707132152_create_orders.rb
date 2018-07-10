class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :meal_id
      t.datetime :date
      t.text     :comment

      t.timestamps
    end
  end
end
