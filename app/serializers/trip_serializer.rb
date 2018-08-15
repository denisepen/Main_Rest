class TripSerializer < ActiveModel::Serializer
  attributes :id, :date, :comment, :status

belongs_to :user
# has_many :orders
has_many :meals
end
