class RenameTaskIdToProjectId < ActiveRecord::Migration[8.0]
  def change
    rename_column :tasks, :task_id, :project_id
  end
end
