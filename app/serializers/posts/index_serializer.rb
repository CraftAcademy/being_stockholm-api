class Posts::IndexSerializer < ActiveModel::Serializer
  attributes :id, :status, :category, :longitude, :latitude
end
