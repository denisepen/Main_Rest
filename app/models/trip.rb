class Trip < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :meals, through: :orders
end
