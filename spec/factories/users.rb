FactoryBot.define do
  factory :user do
    sequence(:id)         { |n| "#{n}"}
    sequence(:nickname)   { |n| "単体テストユーザ#{n}"}
    sequence(:email)      { |n| "unit_testuser#{n}@gmail.com"}
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
