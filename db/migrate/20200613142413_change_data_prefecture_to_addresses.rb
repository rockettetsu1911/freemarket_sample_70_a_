class ChangeDataPrefectureToAddresses < ActiveRecord::Migration[5.2]
  def up
    change_column :addresses, :prefecture, :integer
  end
  
  def down
    change_column :addresses, :prefecture, :string
  end
end
