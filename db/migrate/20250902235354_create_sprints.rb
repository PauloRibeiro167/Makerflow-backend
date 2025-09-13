class CreateSprints < ActiveRecord::Migration[8.0]
  def change
    create_table :sprints do |t|
      t.string :nome_sprint, null: false
      t.date :data_inicio
      t.date :data_fim
      t.text :objetivo_sprint

      t.timestamps
    end
    add_index :sprints, :nome_sprint
    add_index :sprints, :data_inicio
    add_index :sprints, :data_fim
  end
end
