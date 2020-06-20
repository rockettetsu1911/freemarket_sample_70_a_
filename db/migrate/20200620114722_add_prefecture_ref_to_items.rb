class AddPrefectureRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :prefecture, type: :integer, foreign_key: true, null: false
  end
end
