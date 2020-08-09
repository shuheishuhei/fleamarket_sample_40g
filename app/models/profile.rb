class Profile < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :birthday

    with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
      validates :first_name
      validates :family_name
    end

    with_options format: {with: /^[ぁ-ん]+$/} do
      validates :first_name_kana
      validates :family_name_kana
    end
  end
end
