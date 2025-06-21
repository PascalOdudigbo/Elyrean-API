class ProductImage < ApplicationRecord
  belongs_to :product

  validates :image_url, :image_public_id, presence: true
end
