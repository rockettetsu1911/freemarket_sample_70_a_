class AddCommentStatusToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :comment_status, :integer, default: 0
  end
end
