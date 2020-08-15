FactoryBot.define do
  factory :address do
    destination_first_name       {"花子"}
    destination_family_name      {"山田"}
    destination_first_name_kana  {"はなこ"}
    destination_family_name_kana {"やまだ"}
    post_code                    {1111111}
    prefecture                   {"北海道"}
    city                         {"札幌市"}
    house_number                 {"1丁目1番地"}
    phone_number                {"09011111111"}
  end
end