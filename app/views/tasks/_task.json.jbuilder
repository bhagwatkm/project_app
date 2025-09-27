json.extract! task, :id, :description, :project_id, :due_date, :status, :priority, :created_at, :updated_at
json.url project_task_path(@project,task, format: :json)
