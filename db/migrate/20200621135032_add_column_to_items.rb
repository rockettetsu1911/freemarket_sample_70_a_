class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :prefecture_id, :integer, null: false
    add_column :items, :postage_id, :integer, null: false
    add_column :items, :delivery_date_id, :integer, null: false
  end
end
