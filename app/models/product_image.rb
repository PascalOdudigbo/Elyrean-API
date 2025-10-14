class ProductImage < ApplicationRecord
  belongs_to :product
  belongs_to :variation, class_name: 'ProductVariation', foreign_key: 'variation_id', optional: true

  validates :image_url, :image_public_id, presence: true
end
