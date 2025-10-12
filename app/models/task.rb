class Task < ApplicationRecord
   belongs_to :project 
   validates :title, presence: true
   validates :description, presence: true, length: { minimum: 10, maximum: 200 }
   validates :due_date, presence: true
   validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
   validates :priority, presence: true, inclusion: { in: %w[low medium high] }
   enum :status, { not_started: 'not_started', in_progress: 'in_progress', completed: 'completed' }
end
