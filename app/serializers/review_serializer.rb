class ReviewSerializer < ActiveModel::Serializer
   attributes :id, :title, :comment, :date_posted

  belongs_to :user 
end
