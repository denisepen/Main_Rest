class Trip < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :meals, through: :orders

  def self.total
    # where(trip_id: trip.id).joins(:meal).sum("price")
    joins(:meal).sum("price")
  end
end
