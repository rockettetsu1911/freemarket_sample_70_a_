class Item < ApplicationRecord

  belongs_to :user
  has_many   :tags, through: :item_tags, dependent: :destroy
  has_many   :item_tags
  belongs_to :category
  has_many   :comments,             dependent: :destroy
  has_many   :pictures,             dependent: :destroy
  has_many   :likes,                dependent: :destroy         
  validates_associated :pictures
  accepts_nested_attributes_for :pictures, allow_destroy: true

  with_options presence: true do
    validates :user
    validates :pictures
    validates :name,        length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :condition,   exclusion: { in: %w(---), message: 'を入力してください' }
    validates :price,       numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :user_id
    validates :category_id
  end

  enum condition:{
    '---':         0,
    unused:        1, 
    nearly_unused: 2, 
    not_injured:   3, 
    bit_injured:   4, 
    injured:       5,
    bad:           6
  }

end
