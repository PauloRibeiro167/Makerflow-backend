class CreateUserProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :user_projects do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :projeto, null: false
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
