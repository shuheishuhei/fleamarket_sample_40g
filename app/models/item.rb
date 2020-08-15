class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :category


  validates :name, length: { maximum: 40}, presence: true 
  validates :introduction, length: {maximum: 1000}, presence: true
  validates :price,presence: true, numericality: {only_integer: true}
  validates :price, numericality: {greater_than_or_equal_to: 300}
  validates :price, numericality: {less_than: 10000000}
  validates :image, presence: true
  validates :condition, presence: true
  validates :prefecture, presence: true
  validates :day, presence: true
  validates :postage, presence: true
  validates :way, presence: true
  validates :status, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to_active_hash :prefecture
  # belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :way
  belongs_to_active_hash :status
end
