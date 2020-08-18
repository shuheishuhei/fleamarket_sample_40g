class Way < ActiveHash::Base

  self.data = [
    {id: 1, name: '未定'}, {id: 2, name: 'ゆうメール'}, {id: 3, name: '普通郵便'}, {id: 4, name: 'レターパック'}, {id: 5, name: 'クロネコヤマト'}, {id: 6, name: 'ゆうパック'}
  ]

  include ActiveHash::Associations
  has_many :items

end