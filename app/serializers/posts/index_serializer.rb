class Posts::IndexSerializer < ActiveModel::Serializer
  attributes :id, :status, :category, :longitude, :latitude
  belongs_to :user, serializer: Users::Serializer
end
