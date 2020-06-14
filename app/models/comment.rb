class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates :text, presence: true
  validates :user_id, :item_id, presence:true
  validates :text, presence: { message: "コメントを入力してください" }
end
