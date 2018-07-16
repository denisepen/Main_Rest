class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.datetime :date
      t.text :comment
      t.text :status, default: "new"

      t.timestamps
    end
  end
end
