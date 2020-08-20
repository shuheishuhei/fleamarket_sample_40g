class User < ApplicationRecord
  
  has_many :items
  has_one :profile
  has_one :address
  has_one :card, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: {case_sensitive: false}
    validates :password, length: {minimum: 7}
  end
end