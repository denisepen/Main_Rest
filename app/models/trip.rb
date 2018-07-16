class Trip < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :meals, through: :orders


  def total
    # where(trip_id: trip.id).joins(:meal).sum("price")
    # joins(:meal).sum("price")
    meals.sum(&:price)
  end

  def self.admin_total
    joins(:meals).sum("price")
  end
end
