class Posts::ShowSerializer < ActiveModel::Serializer
  attributes :id, :status, :caption, :category, :longitude, :latitude, :created_at  
end
