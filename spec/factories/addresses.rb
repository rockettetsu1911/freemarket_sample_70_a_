FactoryBot.define do
  factory :address do
    id                         {"1"}
    dest_first_name            {"太郎"} 
    dest_last_name             {"手洲戸"}
    dest_first_name_kana       {"タロウ"}
    dest_last_name_kana        {"テスト"}
    zip_code                   {"1500041"}
    prefecture                 {"tokyo"}
    city                       {"渋谷区"}
    block_number               {"神南１ー１２ー６"}
    building                   {""}
    telephone                  {""}

    association                :user
    user                       {user.owner}
  end
end
