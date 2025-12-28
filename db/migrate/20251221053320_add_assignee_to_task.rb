class AddAssigneeToTask < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :assignee, foreign_key: { to_table: :users }, index: true
  end
end
