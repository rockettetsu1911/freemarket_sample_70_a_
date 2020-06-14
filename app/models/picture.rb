class Picture < ApplicationRecord

  belongs_to :item

  validates :image, :item_id, presence: true

  validates :image, presence: { message: "写真を選択してください" }
end
