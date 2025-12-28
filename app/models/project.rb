class Project < ApplicationRecord
    belongs_to :organization
    has_many :tasks, dependent: :destroy
   has_many :taggings, as: :taggable, dependent: :destroy
   has_many :tags, through: :taggings
    validates :name, presence: true, uniqueness:true
    validates :description, presence: true, length: { minimum: 10, maximum: 200 }
    enum :status, [ :active, :archived, :completed ]
  after_create -> { Rails.logger.info("Congratulations, the callback has run!") }

  
    scope :filter_by_tag, ->(tag_id) {
    tag_id.present? ? joins(:tags).where(tags: { id: tag_id }) : all
  }

  scope :recent, ->(limit) {
    order(created_at: :desc).limit(limit)
  }
end
#todo 
# status should be an enum with values like 'active', 'completed', 'archived'
# In view, form.html erb for project status dropdown should show these values