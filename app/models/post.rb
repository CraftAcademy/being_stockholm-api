class Post < ApplicationRecord
  enum status: [:published, :pending, :declined]
  enum category: [:work, :play]

  validates_presence_of :caption, :status, :category, :latitude, :longitude
  validates :caption, length: { maximum: 140 }

end
