class Meal < ApplicationRecord

  has_many :orders
  has_many :trips, through: :orders
  validates :name, :description, :price, :category, presence: true
  scope :low_cal, -> { where("calorie_count <= ?", 450) }


  def self.by_category(category)
    where(category: category)
  end

  def self.meal_count
    # meals = joins(:trips).group(:name).count

    sql = "SELECT meals.name, COUNT(meals.name) AS total FROM trips
    LEFT OUTER JOIN orders
    ON orders.trip_id = trips.id
    LEFT OUTER JOIN meals
    ON orders.meal_id = meals.id
    GROUP BY meals.name
    ORDER BY total DESC
    LIMIT 1".
    result = ActiveRecord::Base.connection.execute(sql)
    result = result[0]
    name = result['name']
    total = result['total']

    puts name
    puts total
    # meals = joins(:trips).select("COUNT(name) AS total").group(:name)
    # raise records_array
    # puts records_array
    # meals.first.total
  end
end
