class Image < ApplicationRecord
  mount_uploadder :src, ImageUploader
end
