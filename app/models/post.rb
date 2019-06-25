class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  enum status: [:published, :pending, :declined]
  enum category: [:work, :play]

  validates_presence_of :caption, :category, :latitude, :longitude, :address
  validates :caption, length: { maximum: 140 }

end
