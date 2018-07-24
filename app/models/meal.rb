class Meal < ApplicationRecord

  has_many :orders
  has_many :trips, through: :orders
  validates :name, :description, :price, :category, presence: true
  scope :low_cal, -> { where("calorie_count <= ?", 450) }


  def self.by_category(category)
    where(category: category)
  end

  def self.meal_count
    meal_obj = joins(:trips).group(:name).count
    
    # meal_obj.to_a
  end
end
