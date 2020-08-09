class Item < ApplicationRecord
  has_many :images
  mount_uploader :image, ImageUploader
  accepts_neated_attributes_for :images, allow_destroy: true
end
