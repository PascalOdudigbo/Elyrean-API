class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id'

  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy # An order has one payment
  has_many :returns, dependent: :restrict_with_error # There can be miltipe returns fpr thr order items
  has_many :refunds, dependent: :restrict_with_error

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w(Pending Processing Shipped Delivered Cancelled Refunded) } # Define valid statuses
end
