class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.string :title
      t.text :comment
      t.datetime :date_posted

      t.timestamps
    end
  end
end
