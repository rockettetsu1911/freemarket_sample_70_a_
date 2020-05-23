class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string      :dest_first_name,      null:false
      t.string      :dest_last_name,       null:false
      t.string      :dest_first_name_kana, null:false
      t.string      :dest_last_name_kana,  null:false
      t.string      :zip_code,             null:false
      t.string      :prefecture,           null:false
      t.string      :city,                 null:false
      t.string      :block_number,         null:false
      t.string      :building,             null:false
      t.string      :telephone
      t.references  :user,                 null:false,  foreign_key:true
      t.timestamps
    end
  end
end
