class CreateProductImages < ActiveRecord::Migration[8.0]
  def change
    create_table :product_images do |t|
      t.references :product, null: false, foreign_key: true
      t.string :image_url, null: false
      t.string :image_public_id, null: false
      t.boolean :is_default, default: false, null: false

      t.timestamps
    end
  end
end
