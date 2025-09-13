class CreateProjetos < ActiveRecord::Migration[8.0]
  def change
    create_table :projetos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
