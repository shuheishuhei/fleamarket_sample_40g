class Item < ApplicationRecord
  validates :name, length: { maximum: 40}, presence: true 
  validates :introduction, length: {maximum: 1000}, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  # belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :way
end
