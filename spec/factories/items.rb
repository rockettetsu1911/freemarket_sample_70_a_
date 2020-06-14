FactoryBot.define do
  
  factory :item do
    name          {"商品名"}
    price         {1000}
    condition     {3}
    explanation   {"商品説明"}
    user
    category
    
  end
  
end
