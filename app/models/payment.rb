class Payment < ApplicationRecord
  belongs_to :order

  validates :order_id, presence: true, uniqueness: true
  validates :stripe_payment_id, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :currency, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true
end