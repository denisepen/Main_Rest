class Meal < ApplicationRecord
  has_many :ingredients
  has_many :orders
  has_many :users, through: :orders
  accepts_nested_attributes_for :ingredients
end
