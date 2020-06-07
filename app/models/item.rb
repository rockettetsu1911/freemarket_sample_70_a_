class Item < ApplicationRecord

  belongs_to :user
  has_many   :tags, through: :item_tags, dependent: :destroy
  has_many   :item_tags
  belongs_to :category
  has_many   :comments,             dependent: :destroy
  has_many   :pictures,             dependent: :destroy
  has_many   :likes,                dependent: :destroy         

  validates :name, :price, :condition, :explanation, :user_id, :category_id,
            presence: true

  validates :name,        presence: { message: "商品名を入力してください" }
  validates :price,       presence: { message: "金額を入力してください" }
  validates :condition,   presence: { message: "状態を選択してください" }
  validates :explanation, presence: { message: "商品内容を入力してください" }

  accepts_nested_attributes_for :pictures, allow_destroy: true
  validates_associated :pictures
  
  enum condition:{
    '---':         0,
    unused:        1, 
    nearly_unused: 2, 
    not_injured:   3, 
    bit_injured:   4, 
    injured:       5,
    bad:           6
  }

  def set_ancestry(relation, key)
    array = ["---"]

    case relation
    when 'parent'
      Category.where(ancestry: nil).each do |parent|
        array << parent.name
      end
      return array
    when 'children'
      return Category.find_by(name: key).children
    when 'grandchildren'
      return Category.find(key).children
    end
  end

end
