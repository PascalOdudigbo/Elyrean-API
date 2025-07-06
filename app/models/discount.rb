class Discount < ApplicationRecord
    has_many :discount_products, dependent: :destroy
    has_many :products, through: :discount_products

    validates :name, :discount_percent, :valid_from, :valid_until, presence: true
    validates :image_url, :image_public_id, presence: true
    validates :discount_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :valid_until_after_valid_from

    private

    def valid_until_after_valid_from
        if valid_until.present? && valid_until < valid_from
            errors.add(:valid_until, "must be after the valid from date")
        end
    end
end
