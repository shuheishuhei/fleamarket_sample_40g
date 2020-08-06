class Address < ApplicationRecord
  belongs_to :user, option: true
  validates :distination_first_name, :distination_family_name, :distination_first_name_kana, :distination_family_name_kana, :post_code, :prefucture_code, :city, :house_number, presence: true
  validates :phone_number, uniqueness: true
end
