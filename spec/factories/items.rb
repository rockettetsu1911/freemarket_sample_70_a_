FactoryBot.define do
  
  factory :item do
    name               {"商品名"}
    price              {1000}
    condition          {'not_injured'}
    explanation        {"商品説明"}
    user
    category
    postage_id         {1}
    prefecture_id      {13}
    delivery_date_id   {1}
  end

  factory :item_valid, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      item.pictures << build(:picture_0)
      item.pictures << build(:picture_1)
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end

  factory :item_without_category, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      item.pictures << build(:picture)
    end
  end
  
  factory :item_without_picture, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end
  
  factory :item_with_a_picture, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      item.pictures << build(:picture_0)
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end
  
  factory :item_with_ten_pictures, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      (0..9).each do |num|
        item.pictures << build(:"picture_#{num}")
      end
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end
  
  factory :item_with_eleven_pictures, parent: :item do |item|
    after(:build) do |item|
      user = create(:user)
      item.user_id = user.id
      (0..10).each do |num|
        item.pictures << build(:"picture_#{num}")
      end
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end

  factory :item_without_user, parent: :item do |item|
    after(:build) do |item|
      item.pictures << build(:picture_0)
      item.pictures << build(:picture_1)
      parent_category = create(:category)
      child_category = parent_category.children.create(name: 'トップス')
      grand_child_category = child_category.children.create(name: '半袖')
      item.category_id = grand_child_category.id
    end
  end
  
end