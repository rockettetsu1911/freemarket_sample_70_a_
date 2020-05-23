class CreateItemTags < ActiveRecord::Migration[5.2]
  def change
    create_table :item_tags do |t|
      t.bigint :item_id, null:false, foreign_key:true
      t.references :tag,  null:false, foreign_key:true
      t.timestamps
    end
  end
end
