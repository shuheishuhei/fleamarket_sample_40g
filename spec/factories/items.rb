FactoryBot.define do
  
  factory :item do
    name         {"テスト"}
    introduction {"テスト用のアイテムです"}
    price        {500}
    image        {"logo.png"}
    condition_id    {2}
    prefecture_id   {2}
    day_id          {2}
    postage_id      {2}
    way_id          {2}
    category_id     {11}
    status_id       {2}
  end
end