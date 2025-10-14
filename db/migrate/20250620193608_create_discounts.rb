class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.string :name, index: { unique: true }, null: false
      t.text :description
      t.decimal :discount_percent, precision: 5, scale: 2, null: false # e.g. 25.99% 
      t.string :image_url, null: false
      t.string :image_public_id, null: false
      t.datetime :valid_from, null: false
      t.datetime :valid_until, null: false

      t.timestamps
    end
  end
end
