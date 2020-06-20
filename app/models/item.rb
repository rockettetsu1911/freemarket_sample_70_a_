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
 
  validates :pictures, presence: true, length: { maximum: 10, message: 'は10枚以内で入力してください' }, on: :create
  with_options presence: true do
    validates :name,        length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :condition,   exclusion: { in: %w(---), message: 'を入力してください' }
    validates :price,       numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  enum condition:{
    unused:        1, 
    nearly_unused: 2, 
    not_injured:   3, 
    bit_injured:   4, 
    injured:       5,
    bad:           6
  }
 
end
