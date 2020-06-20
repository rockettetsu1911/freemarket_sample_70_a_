class ChangeColumnToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :view_count, :integer, default: 0
  end
end
