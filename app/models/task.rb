class Task < ApplicationRecord

   belongs_to :project 
   belongs_to :assignee, class_name: 'User', optional: true
   has_many :taggings, as: :taggable, dependent: :destroy
   has_many :tags, through: :taggings
   validates :title, presence: true
   validates :description, presence: true, length: { minimum: 10, maximum: 200 }
   validates :due_date, presence: true
   validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
   validates :priority, presence: true, inclusion: { in: %w[low medium high] }
   enum :status, { not_started: 'not_started', in_progress: 'in_progress', completed: 'completed' }
   enum :priority, { high: 'high', medium: 'medium', low: 'low' }

   scope :sorted_by_assignee_email, ->(direction = 'asc') {
     left_joins(:assignee).order(Arel.sql("CASE WHEN users.email IS NULL THEN 0 ELSE 1 END, users.email #{direction}"))
   }
   scope :searched_by_title, ->(query) {
     where("tasks.title LIKE ?", "%#{query}%")
   }

   scope :filter_by_status, ->(status) {
     where(status: status)
   }

    scope :filter_by_priority, ->(priority) {
     where(priority: priority)
   }

    scope :filter_by_duedate, ->(due_date) {
     where(due_date: due_date)
   }

  scope :filter_by_tag, ->(tag_id) {
    tag_id.present? ? joins(:tags).where(tags: { id: tag_id }) : all
  }

  scope :assigned_to, ->(user) {
     where(assignee: user)
   }

   scope :overdue, -> {
     where("due_date < ? AND status != ?", Date.today, 'completed')
   }

    scope :due_today, -> { 
      where(due_date: Date.today).not_completed 
    }

    scope :due_this_week, -> { 
      where(due_date: Date.today..Date.today.end_of_week).not_completed 
    }

    scope :recent, ->(limit) {
      order(created_at: :desc).limit(limit)
    }


      scope :filter_by_assignee, ->(assignee_id=nil) {
                return where(assignee_id: nil) if assignee_id.blank?
     where(assignee_id: assignee_id)


   }

   #todo - filter by due date scope

  #  def self.searched_by_title(query, tasks = nil) // example of alternative implementation usng class method
  #    tasks ||= all
  #    tasks.where("tasks.title LIKE ?", "%#{query}%")   
  #  end

  #  def self.filter_by_status(status, tasks = nil)
  #    tasks ||= all
  #    tasks.where(status: status)
  #  end  

end
