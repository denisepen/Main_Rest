class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image, :first_name, :last_name, :admin

  has_many :trips
  has_many :reviews
end
