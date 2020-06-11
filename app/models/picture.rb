class Picture < ApplicationRecord
  mount_uploader :image, PictureUploader
  belongs_to :item
  
  validates :image, :item_id, presence: true
  validates :image, presence: { message: "写真を選択してください" }

end
