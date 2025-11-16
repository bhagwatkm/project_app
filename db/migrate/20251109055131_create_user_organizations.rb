class CreateUserOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :user_organizations do |t|
      t.integer :user_id
      t.integer :organization_id
      t.string :role

      t.timestamps
    end
  end
end
