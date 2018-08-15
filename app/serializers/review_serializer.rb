class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :date_posted, :user_id

  belongs_to :user
end
