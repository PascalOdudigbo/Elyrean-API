class CreateReturnedItems < ActiveRecord::Migration[8.0]
  def change
    create_table :returned_items do |t|
      t.references :return, null: false, foreign_key: true
      t.references :order_item, null: false, foreign_key: true
      t.integer :quantity, null: false # Quantity of this specific order_item being returned
      t.decimal :return_price, precision: 10, scale: 2, null: false # Price specific to this returned item

      t.timestamps

      # Ensures that a specific order_item can only be listed once per return
      t.index [:return_id, :order_item_id], unique: true
    end
  end
end
