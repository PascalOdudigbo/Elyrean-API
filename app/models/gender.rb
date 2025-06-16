class Gender < ApplicationRecord
    has_many :categories, foreign_key: "gender_id", dependent: :restrict_with_error 

    validates :name, presence: true, uniqueness: true
end
