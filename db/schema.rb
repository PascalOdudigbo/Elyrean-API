# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_28_124301) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address_line1", null: false
    t.string "address_line2"
    t.string "city", null: false
    t.string "postal_code", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "artists", primary_key: "user_id", force: :cascade do |t|
    t.string "name", null: false
    t.text "bio"
    t.string "image"
    t.string "image_public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.bigint "variation_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "product_id", "variation_id"], name: "index_cart_items_on_cart_id_and_product_id_and_variation_id", unique: true
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["variation_id"], name: "index_cart_items_on_variation_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "gender_id", null: false
    t.string "image"
    t.string "image_public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_categories_on_gender_id"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "release_date"
    t.boolean "active", default: true, null: false
    t.string "image"
    t.string "image_public_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_collections_on_name", unique: true
  end

  create_table "discount_products", force: :cascade do |t|
    t.bigint "discount_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id", "product_id"], name: "index_discount_products_on_discount_id_and_product_id", unique: true
    t.index ["discount_id"], name: "index_discount_products_on_discount_id"
    t.index ["product_id"], name: "index_discount_products_on_product_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "discount_percent", precision: 5, scale: 2, null: false
    t.string "image_url", null: false
    t.string "image_public_id", null: false
    t.datetime "valid_from", null: false
    t.datetime "valid_until", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_discounts_on_name", unique: true
  end

  create_table "genders", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genders_on_name", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.bigint "variation_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
    t.index ["variation_id"], name: "index_order_items_on_variation_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total", precision: 10, scale: 2, null: false
    t.string "status", default: "Pending", null: false
    t.bigint "shipping_address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "stripe_payment_id", null: false
    t.string "stripe_customer_id"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", null: false
    t.string "status", null: false
    t.string "payment_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id", unique: true
    t.index ["stripe_payment_id"], name: "index_payments_on_stripe_payment_id", unique: true
  end

  create_table "product_images", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "variation_id"
    t.string "image_url", null: false
    t.string "image_public_id", null: false
    t.boolean "is_default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
    t.index ["variation_id"], name: "index_product_images_on_variation_id"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating", null: false
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_reviews_on_product_id"
    t.index ["user_id", "product_id"], name: "index_product_reviews_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_product_reviews_on_user_id"
  end

  create_table "product_variations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "size", null: false
    t.string "color", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "stock", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "size", "color"], name: "index_product_variations_on_product_id_and_size_and_color", unique: true
    t.index ["product_id"], name: "index_product_variations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "base_price", null: false
    t.bigint "category_id", null: false
    t.bigint "collection_id", null: false
    t.bigint "artist_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_products_on_artist_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["collection_id"], name: "index_products_on_collection_id"
  end

  create_table "refunds", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "return_id"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", null: false
    t.string "status", default: "Pending", null: false
    t.string "refund_method", null: false
    t.string "stripe_refund_id"
    t.bigint "approver_id", null: false
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_refunds_on_approver_id"
    t.index ["order_id"], name: "index_refunds_on_order_id"
    t.index ["return_id"], name: "index_refunds_on_return_id"
  end

  create_table "returned_items", force: :cascade do |t|
    t.bigint "return_id", null: false
    t.bigint "order_item_id", null: false
    t.integer "quantity", null: false
    t.decimal "return_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_returned_items_on_order_item_id"
    t.index ["return_id", "order_item_id"], name: "index_returned_items_on_return_id_and_order_item_id", unique: true
    t.index ["return_id"], name: "index_returned_items_on_return_id"
  end

  create_table "returns", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.text "reason"
    t.decimal "total_amount_returned", precision: 10, scale: 2, null: false
    t.string "status", default: "Pending", null: false
    t.datetime "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_returns_on_order_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "user_wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_user_wishlists_on_product_id"
    t.index ["user_id", "product_id"], name: "index_user_wishlists_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_user_wishlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.bigint "role_id", null: false
    t.boolean "active", default: false, null: false
    t.string "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "addresses", "users", on_delete: :cascade
  add_foreign_key "artists", "users"
  add_foreign_key "cart_items", "carts", on_delete: :cascade
  add_foreign_key "cart_items", "product_variations", column: "variation_id"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "categories", "genders"
  add_foreign_key "discount_products", "discounts"
  add_foreign_key "discount_products", "products"
  add_foreign_key "order_items", "orders", on_delete: :cascade
  add_foreign_key "order_items", "product_variations", column: "variation_id"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "addresses", column: "shipping_address_id"
  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "payments", "orders"
  add_foreign_key "product_images", "product_variations", column: "variation_id"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_reviews", "products", on_delete: :cascade
  add_foreign_key "product_reviews", "users", on_delete: :cascade
  add_foreign_key "product_variations", "products", on_delete: :cascade
  add_foreign_key "products", "categories"
  add_foreign_key "products", "collections"
  add_foreign_key "products", "users", column: "artist_id"
  add_foreign_key "refunds", "orders"
  add_foreign_key "refunds", "returns"
  add_foreign_key "refunds", "users", column: "approver_id"
  add_foreign_key "returned_items", "order_items"
  add_foreign_key "returned_items", "returns"
  add_foreign_key "returns", "orders"
  add_foreign_key "user_wishlists", "products", on_delete: :cascade
  add_foreign_key "user_wishlists", "users", on_delete: :cascade
  add_foreign_key "users", "roles"
end
