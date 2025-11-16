class Organization < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, length: { minimum: 5, maximum: 200 }
    
    has_many :projects, dependent: :destroy 
    has_many :users, through: :projects
    has_many :user_organizations
    has_many :users, through: :user_organizations
    
    # Additional methods or associations can be added here as needed
end
