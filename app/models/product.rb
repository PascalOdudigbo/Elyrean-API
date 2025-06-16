class Product < ApplicationRecord
  belongs_to :category
  belongs_to :collection
  belongs_to :artist, class_name: 'User', foreign_key: 'artist_id' # Product's artist is a User 

  has_many :variations, class_name: 'ProductVariation', dependent: :destroy
  has_many :images, class_name: 'ProductImage', dependent: :destroy
  has_many :reviews, class_name: 'ProductReview', dependent: :destroy
  has_many :order_items, dependent: :restrict_with_error
  has_many :cart_items, dependent: :restrict_with_error
  has_many :user_wishlists, dependent: :destroy

  has_many :discount_products, dependent: :destroy
  has_many :discounts, through: :discount_products

  validates :name, presence: true
  validates :base_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true
  validates :collection, presence: true
  validates :artist, presence: true
  validates :active, presence: true
end
