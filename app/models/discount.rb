class Discount < ApplicationRecord
    has_many :discount_products, dependent: :destroy
    has_many :products, through: :discount_products

    validates: :name, :discount_precent, :valid_from, :valid_until, presence: true
    vaidates: :discount_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validate :valid_until_after_valid_from

    private

    def valid_until_after_valid_from
        if valid_until.present? && valid_until < valid_from
            errors.add(:valid_until, "must be after the valid from date")
        end
    end
end
