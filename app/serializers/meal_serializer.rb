class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :calorie_count, :category

  has_many :orders
  has_many :trips
end
