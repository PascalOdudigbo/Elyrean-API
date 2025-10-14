class CreateDiscountProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :discount_products do |t|
      t.references :discount, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
      t.index [:discount_id, :product_id], unique: true # Unique combination
    end
  end
end
