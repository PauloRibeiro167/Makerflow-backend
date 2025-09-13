class CreateItemDeAcaos < ActiveRecord::Migration[8.0]
  def change
    create_table :item_de_acaos do |t|
      t.references :id_reuniao, null: false, foreign_key: { to_table: :reuniaos }
      t.references :id_kanban, null: false, foreign_key: { to_table: :quadro_kanbans }
      t.text :descricao_acao
      t.string :responsavel
      t.date :data_prazo
      t.string :status

      t.timestamps
    end
    add_index :item_de_acaos, :id_reuniao_id
    add_index :item_de_acaos, :id_kanban_id
    add_index :item_de_acaos, :status
  end
end
