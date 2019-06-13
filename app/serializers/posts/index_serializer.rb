class Posts::IndexSerializer < ActiveModel::Serializer
  attributes :id, :status, :longitude, :latitude
end
