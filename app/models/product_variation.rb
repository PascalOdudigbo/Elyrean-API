class ProductVariation < ApplicationRecord
  belongs_to :product
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :restrict_with_error

  validates :size, :color, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :stock, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :color, uniqueness: {scope: [:product_id, :size], message:  message: "This combination of size and color already exists for this product"}
end
