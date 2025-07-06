class UserWishlist < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, uniqueness: { scope: :product_id, message: "You have already wishlisted this product" }
end
