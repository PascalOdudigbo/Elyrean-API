class Artist < ApplicationRecord
  belongs_to :user # Artist "is a" User
  has_many :products, foreign_key: 'artist_id', dependent: :nullify # Products lose artists if artist is deleted, not cascade

  validates :user_id, presence: true, uniqueness: true #Enforces 1:1 relationship
  validates :name, presence: true, uniqueness: true
  validates :bio, presence: true
end
