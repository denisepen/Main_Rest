class Ingredient < ApplicationRecord
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  validates_uniqueness_of :name
  validates_presence_of :name
end
