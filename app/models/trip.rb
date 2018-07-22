class Trip < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :meals, through: :orders
  scope :today, -> { where("date >= ?", Time.zone.today.beginning_of_day) }
  scope :this_week, -> { where('date BETWEEN ? AND ?', 7.days.ago, Time.now) }
  scope :this_year, -> { where('date BETWEEN ? AND ?', 365.days.ago, Time.now) }
  scope :past_hour, -> { where('date BETWEEN ? AND ?', 60.minutes.ago, Time.now) }
  scope :greater_than_twenty, -> { where'total > ?', 20}

  def total
    meals.sum(&:price)
  end

  # def self.admin_total
  #   joins(:meals).sum("price")
  # end



end
