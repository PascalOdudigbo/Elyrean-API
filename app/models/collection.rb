class Collection < ApplicationRecord
    has_many :products, dependent: :nullify # If a collection is deleted, products lose their collection association.
    has_many :artists, -> { distinct }, through: :products, source: :artist # `source: :artist` tells Rails to use the `artist` association on the Product model.
                                                   # The `artist` association on Product is defined as `belongs_to :artist, class_name: 'User', foreign_key: 'artist_id'`

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true    
    validates :active, inclusion: { in: [true, false] }                                           
end