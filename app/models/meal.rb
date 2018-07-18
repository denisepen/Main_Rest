class Meal < ApplicationRecord

  has_many :orders
  has_many :trips, through: :orders
  validates :name, :description, :price, :category, presence: true
  scope :low_cal, -> { where("calorie_count <= ?", 350) }


  def self.by_category(category)
    where(category: category)
  end
end
