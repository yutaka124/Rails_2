class Room < ApplicationRecord
  has_many :reservations

  def display_image_url
    image_url || 'default-image-room.png'
  end
end
