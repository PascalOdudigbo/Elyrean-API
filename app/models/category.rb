class Category < ApplicationRecord
  belongs_to :gender
  has_many :products, foreign_key: 'category_id', dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
