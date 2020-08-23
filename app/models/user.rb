class User < ApplicationRecord
  
  has_many :items
  has_one :profile
  has_one :address
  has_one :card, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, uniqueness: true
    validates :email, uniqueness: {case_sensitive: false}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i , message:"メールアドレスを正しく入力してください"}
    validates :password, length: {minimum: 7}
  end
end