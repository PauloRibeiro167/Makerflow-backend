class CreatePautaReuniaos < ActiveRecord::Migration[8.0]
  def change
    create_table :pauta_reuniaos do |t|
      t.references :id_reuniao, null: false, foreign_key: { to_table: :reuniaos }
      t.text :topico_item
      t.text :anotacoes_discussao
      t.text :decisoes_tomadas
      t.references :id_kanban, null: false, foreign_key: { to_table: :quadro_kanbans }

      t.timestamps
    end
    add_index :pauta_reuniaos, :id_reuniao_id
    add_index :pauta_reuniaos, :id_kanban_id
  end
end
