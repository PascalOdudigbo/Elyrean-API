class Return < ApplicationRecord
  belongs_to :order
  has_many :returned_items # A return can have many returned items
  has_many :order_items, through: :returned_items
  has_one :refund, optional: true, dependent: :nullify # refund_id can be null

  enum status: { Pending: 'Pending', Approved: 'Approved', Received: 'Received', Processed: 'Processed', Rejected: 'Rejected' }

  validates :status, presence: true
  validates :order_id, presence: true
  validates :total_amount_returned, numericality: {greater_than_or_equal_to: 0}

  # Callback to calculate total_amount_returned from associated returned_items
  before_save :calculate_total_amount_returned

  private

  def calculate_total_amount_returned
    self.total_amount_returned = returned_items.sum(:return_price)
  end
end
