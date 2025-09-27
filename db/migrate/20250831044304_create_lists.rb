class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.references :board, null: false, foreign_key: true
      t.string :name
      t.integer :position
      t.integer :wip_limit

      t.timestamps
    end
  end
end
