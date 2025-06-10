class Address < ApplicationRecord
  belongs_to :user
  has_many :orders, foreign_key: 'shipping_address_id', dependent: :restrict_with_error

  validates :address_line1, :city, :state, :postal_code, :country, presence: true
end
