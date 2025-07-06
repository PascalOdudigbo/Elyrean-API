class CreateUserWishlists < ActiveRecord::Migration[8.0]
  def change
    create_table :user_wishlists do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.references :product, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps

      t.index [:user_id, :product_id], unique: true # One user can wishlist a product only once

    end
  end
end
