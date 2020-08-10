class Image < ApplicationRecord
  mount_uploadder :src, ImageUploader
  belongs_to :image
end
