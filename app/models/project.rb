class Project < ApplicationRecord
    belongs_to :organization
    has_many :tasks, dependent: :destroy
    validates :name, presence: true, uniqueness:true
    validates :description, presence: true, length: { minimum: 10, maximum: 200 }
    enum :status, [ :active, :archived, :completed ]

end
#todo 
# status should be an enum with values like 'active', 'completed', 'archived'
# In view, form.html erb for project status dropdown should show these values