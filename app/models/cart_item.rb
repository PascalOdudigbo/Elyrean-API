class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :variation, class_name: 'ProductVariation'

  validates :quantity, presence: true, numericallity: {only_integer: true, greater_than: 0}
  validates :cart_id, uniqueness: {scope: [:product_id, :variation_id], message: "This item already exists in the cart"}
end
