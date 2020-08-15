FactoryBot.define do
  
  factory :item do
    name         {"テスト"}
    introduction {"テスト用のアイテムです"}
    price        {500}
    image        {"logo.png"}
    condition    {2}
    prefecture   {2}
    day          {2}
    postage      {2}
    way          {2}
    status       {2}
  end
end