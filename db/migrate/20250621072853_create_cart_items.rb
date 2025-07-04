class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: {on_delete: :cascade}
      t.references :product, null: false, foreign_key: true
      t.references :variation, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
      t.index [:cart_id, :product_id, :variation_id], unique: true
    end
  end
end
