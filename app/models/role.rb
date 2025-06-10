class Role < ApplicationRecord
    has_many :users, dependent: :restrict_with_error #Don't delete role if user exists
    validates :name, presence: true, uniqueness: true # Ensure each role has a unique name
end
