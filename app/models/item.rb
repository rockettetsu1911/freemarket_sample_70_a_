class Item < ApplicationRecord
 
  has_many   :tags, through: :item_tags
  has_many   :item_tags
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
    validates :user
    validates :pictures,    length: { maximum: 10, message: 'は10枚以内で入力してください' }
    validates :name,        length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :category_id
    validates :condition,   exclusion: { in: %w(---), message: 'を入力してください' }
    validates :price,       numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :user_id
  end
 
  validate :category_id_is_valid
 
  enum condition:{
    '---':         0,
    unused:        1, 
    nearly_unused: 2, 
    not_injured:   3, 
    bit_injured:   4, 
    injured:       5,
    bad:           6
  }
 
  def category_id_is_valid
    errors.messages.delete(:category) unless Category.find_by(id: category_id)
  end
 
end
