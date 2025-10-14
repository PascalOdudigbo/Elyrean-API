class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: {on_delete: :cascade}
      t.references :product, null: false, foreign_key: true
      t.references :variation, null: false, foreign_key: { to_table: :product_variations }
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
