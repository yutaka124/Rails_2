class Room < ApplicationRecord
  has_one_attached :image
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true

  def display_image_url
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    else
      'default-image-room.png'
    end
  end
end
