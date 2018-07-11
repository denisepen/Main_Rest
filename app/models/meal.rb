class Meal < ApplicationRecord

  has_many :orders
  has_many :trips, through: :orders

end
