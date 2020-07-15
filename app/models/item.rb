class Item < ApplicationRecord
 
  has_many   :item_tags, dependent: :destroy
  has_many   :tags, through: :item_tags
  belongs_to :user
  belongs_to :category
  has_many   :comments,             dependent: :destroy
  has_many   :pictures,             dependent: :destroy
  has_many   :likes,                dependent: :destroy
  validates_associated :pictures
  accepts_nested_attributes_for :pictures, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_date
 
  with_options presence: true do
    validates :pictures,          length: { maximum: 10, message: 'は10枚以内で入力してください' }, on: :create
    validates :name,              length: { maximum: 40 }
    validates :explanation,       length: { maximum: 1000 }
    validates :category_id
    validates :condition,         exclusion: { in: %w(---), message: 'を入力してください' }
    validates :price,             numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :user_id
    validates :postage_id,        numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
    validates :prefecture_id,     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 47 }
    validates :delivery_date_id,  numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  end

  enum condition:{
    unused:        1, 
    nearly_unused: 2, 
    not_injured:   3, 
    bit_injured:   4, 
    injured:       5,
    bad:           6
  }

  after_create do
    item = Item.find_by(id: self.id)
    tags = self.explanation.scan(/[#＃](?<!#＃)[\w\p{Han}０-９ぁ-ヶｦ-ﾟー]+/).map(&:strip)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.delete('#＃'))
      item.tags << tag
    end
  end

  before_update do
    item = Item.find_by(id: self.id)
    ids = item.tags.ids
    tags = self.explanation.scan(/[#＃](?<!#＃)[\w\p{Han}０-９ぁ-ヶｦ-ﾟー]+/).map(&:strip)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.delete('#＃'))
      if (isExist = item.tags.where(name: tag.name)) != []
        ids.delete(isExist[0].id)
      else
        item.tags << tag
      end
    end
    ids.each do |id|
      item.tags.delete(id)
    end
  end

  def self.search(keyword)
    return Item.all unless keyword
    Item.where(['name LIKE ? OR explanation LIKE ?', "%#{keyword}%", "%#{keyword}%"])
  end
 
end
