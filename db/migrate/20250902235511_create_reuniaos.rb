class CreateReuniaos < ActiveRecord::Migration[8.0]
  def change
    create_table :reuniaos do |t|
      t.date :data_reuniao
      t.time :horario_previsto_inicio
      t.time :horario_previsto_fim
      t.time :horario_real_inicio
      t.time :horario_real_fim
      t.text :tema
      t.text :link_reuniao
      t.text :notas_pessoais
      t.string :facilitador
      t.references :id_sprint, null: false, foreign_key: { to_table: :sprints }

      t.timestamps
    end
    add_index :reuniaos, :data_reuniao
    add_index :reuniaos, :facilitador
  end
end
