class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, length: { minimum: 5, maximum: 200 }
    
    has_many :projects
    has_many :users, through: :projects
    
    # Additional methods or associations can be added here as needed
end
