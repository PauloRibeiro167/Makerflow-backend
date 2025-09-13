class CreateMetricaProjetos < ActiveRecord::Migration[8.0]
  def change
    create_table :metrica_projetos do |t|
      t.string :nome_metrica
      t.decimal :valor_metrica
      t.string :unidade
      t.date :data_captura
      t.references :id_projeto, null: false, foreign_key: { to_table: :quadro_kanbans }
      t.references :id_sprint, null: false, foreign_key: { to_table: :sprints }
      t.references :id_equipe, null: false, foreign_key: { to_table: :equipes }

      t.timestamps
    end
    add_index :metrica_projetos, :id_projeto_id
    add_index :metrica_projetos, :id_sprint_id
    add_index :metrica_projetos, :id_equipe_id
    add_index :metrica_projetos, :data_captura
  end
end
