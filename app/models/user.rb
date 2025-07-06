class User < ApplicationRecord
  has_secure_password # For password hashing and authentication methods

  belongs_to :role
  has_one :artist_profile, class_name: 'Artist', foreign_key: 'user_id', dependent: :destroy # A 1:1 relationship with Artist
  has_one :cart, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :reviews, class_name: 'ProductReview', dependent: :destroy
  has_many :wishlist_items, class_name: 'UserWishlist', dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
