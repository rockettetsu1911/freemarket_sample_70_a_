FactoryBot.define do
  factory :user do
    id                    {"1"}
    nickname              {"テストユーザ"}
    email                 {"testuser@gmail.com"}
    first_name            {"太郎"} 
    last_name             {"手洲戸"}
    first_name_kana       {"タロウ"}
    last_name_kana        {"テスト"}
    birthday              {"1990/05/01"}
    telephone             {"09012345678"}
    introduction          {"サンプル自己紹介です"}
    password              {"testuser"}
    password_confirmation {"testuser"}

  end
end
