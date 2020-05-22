class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates :text, presence: true
  validates :text, presence: { message: "コメントを入力してください" }
end
