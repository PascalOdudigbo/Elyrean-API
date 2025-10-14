class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :variation, class_name: 'ProductVariation'

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
end
