class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :task_id
      t.integer :due_date
      t.string :status
      t.string :priority

      t.timestamps
    end
  end
end
