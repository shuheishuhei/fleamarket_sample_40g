class Item < ApplicationRecord

  belongs_to :category, optional: true

  validates :name, length: {maximum: 40}, presence: true 
  validates :introduction, length: {maximum: 1000}, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 300, less_than: 10000000, only_integer: true}
  validates :item_images, presence: true
  validates :condition_id, presence: true
  validates :prefecture_id, presence: true
  validates :day_id, presence: true
  validates :postage_id, presence: true
  validates :way_id, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true

  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :way
  belongs_to_active_hash :status
end
