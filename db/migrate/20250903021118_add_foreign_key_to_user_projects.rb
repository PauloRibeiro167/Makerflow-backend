class AddForeignKeyToUserProjects < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :user_projects, :projetos
  end
end
