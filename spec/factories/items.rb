FactoryBot.define do
  
  factory :item do
    name          {"商品名"}
    price         {1000}
    condition     {3}
    explanation   {"商品説明"}
    user
    category
    after :build do |item|
      user = create(:user)
      item.user_id = user.id
      item.pictures << build(:picture)
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end
  
end
