class CreateProductVariations < ActiveRecord::Migration[8.0]
  def change
    create_table :product_variations do |t|
      t.references :product, null: false, foreign_key: {on_delete: :cascade}
      t.string :size, null: false
      t.string :color, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false

      t.timestamps

      t.index [:product_id, :size, :color], unique: true # Unique combination
    end
  end
end
