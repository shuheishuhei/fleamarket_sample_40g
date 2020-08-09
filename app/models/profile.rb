class Profile < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :family_name, :first_name, :family_name_kana, :first_name_kana, presence: true, format: { with: /\A[一-龥ぁ-ん]/ } 
  validates :birthday, presence: true
end
