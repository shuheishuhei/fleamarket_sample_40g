class Profile < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :birthday

  # 名前は全角漢字かなカナ全てOK
    with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
      validates :first_name
      validates :family_name
    end
  
  # ふりがなは、全角ひらがなのみOK
    with_options format: {with: /\A[ぁ-ん]+\z/} do
      validates :first_name_kana
      validates :family_name_kana
    end
  end
end
