class CreateProductReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :product_reviews do |t|
      t.references :product, null: false, foreign_key: {on_delete: :cascade}
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.integer :rating, null: false
      t.text :review

      t.timestamps
    end
  end
end
