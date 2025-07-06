class ReturnedItem < ApplicationRecord
  belongs_to :return
  belongs_to :order_item

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :return_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order_item_id, uniqueness: { scope: :return_id, message: "This item is already part of this return" }

  validate :quantity_does_not_exceed_original_or_remaining

  private

  # Custom validation to ensure not more than original quantity is returned,
  # considering previous returns for the same order item.
  def quantity_does_not_exceed_original_or_remaining
    if order_item
      # Sum quantities from all *other* returned_items for this specific order_item,
      # excluding the current instance if it's an update.
      existing_returned_qty_for_item = order_item.returned_items
                                                .where.not(id: id) # Exclude current item if it's an update
                                                .sum(:quantity)

      # Remaining quantity from the original order item that can still be returned
      allowed_to_return = order_item.quantity - existing_returned_qty_for_item
      if quantity > allowed_to_return
        errors.add(:quantity, "exceeds the remaining quantity available for return (#{allowed_to_return}) for this order item")
      elsif quantity <= 0 && new_record? # Prevent creating with zero or negative quantity unless updating to it explicitly
        errors.add(:quantity, "must be greater than 0")
      end
    end
  end
end
