class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.decimal :price
      t.text    :description
      t.integer :calorie_count
      t.string :category

      t.timestamps
    end
  end
end
