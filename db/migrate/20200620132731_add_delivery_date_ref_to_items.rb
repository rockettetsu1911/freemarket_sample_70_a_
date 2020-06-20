class AddDeliveryDateRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :delivery_date, type: :integer, foreign_key: true, null: false
  end
end
