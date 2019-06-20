class Posts::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :status, :caption, :category, :longitude, :latitude, :created_at
  attribute :image

  def image
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      object&.image&.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end

end
