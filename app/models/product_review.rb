class ProductReview < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :product_id, message: "has already reviewed this product" }
end
