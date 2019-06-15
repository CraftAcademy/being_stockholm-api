class Posts::ShowSerializer < ActiveModel::Serializer
  attributes :id, :status, :caption, :category, :longitude, :latitude, :created_at, :image
  #has_one_attached :image, 
  def image
    Post.with_attached_image.where(image: object)
  end
end
