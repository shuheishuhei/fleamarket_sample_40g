class Item < ApplicationRecord
  has_many :images
  mount_uploader :image, ImageUploader
end
