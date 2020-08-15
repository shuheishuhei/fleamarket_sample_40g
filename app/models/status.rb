class Status < ActiveHash::Base
  
  self.data = [
    {id: 1, name: '出品中'}, {id: 2, name: '出品停止'}, {id: 3, name: '取引中'}, {id: 4, name: '取引完了'}
  ]

  include ActiveHash::Associations
  has_many :items

end