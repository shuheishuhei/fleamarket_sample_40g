FactoryBot.define do
  
  factory :item do
    name         {"テスト"}
    introduction {"テスト用のアイテムです"}
    price        {500}
<<<<<<< Updated upstream
    # image        {"logo.png"}
=======
>>>>>>> Stashed changes
    condition_id    {2}
    prefecture_id   {2}
    day_id          {2}
    postage_id      {2}
    way_id          {2}
    category_id     {11}
    status_id       {2}
    user_id         {2}
  end
end