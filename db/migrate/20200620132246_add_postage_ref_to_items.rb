class AddPostageRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :postage, type: :integer, foreign_key: true, null: false
  end
end
