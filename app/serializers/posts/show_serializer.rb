class Posts::ShowSerializer < ActiveModel::Serializer
  attributes :id, :status, :caption, :category, :longitude, :latitude, :created_at, :image
  
  has_one_attached :image do |post|
    post.image
  end
  
end
