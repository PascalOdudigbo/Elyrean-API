class Refund < ApplicationRecord
  belongs_to :order
  belongs_to :return, optional: true
  belongs_to :approver, class_name: 'User', dependent: :restrict_with_error

  enum status: { Pending: 'Pending', Issued: 'Issued', Failed: 'Failed', Cancelled: 'Cancelled' }

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :currency, presence: true
  validates :status, presence: true
  validates :refund_method, presence: true
  validates :approver, presence: true # Ensures an approver is always set

  # Automatically set approved_at when status changes to 'Issued' or similar
  before_save :set_approved_at_if_issued, if: -> { status_changed? && status == 'Issued' }


  private

  def set_approved_at_if_issued
    self.approved_at = Time.current
  end

end
