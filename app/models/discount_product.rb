class DiscountProduct < ApplicationRecord
  belongs_to :discount
  belongs_to :product

  validates :discount_id, :product_id, presence: true
end
