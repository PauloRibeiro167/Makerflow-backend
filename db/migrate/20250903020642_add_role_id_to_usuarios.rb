class AddRoleIdToUsuarios < ActiveRecord::Migration[8.0]
  def change
    add_reference :usuarios, :role, null: false, foreign_key: true
  end
end
