class Review < ApplicationRecord
  belongs_to :user
  validates_presence_of :comment, :date_posted
  validates :comment, length: { minimum: 20 }
end
