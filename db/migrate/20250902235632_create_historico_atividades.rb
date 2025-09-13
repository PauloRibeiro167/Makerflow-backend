class CreateHistoricoAtividades < ActiveRecord::Migration[8.0]
  def change
    create_table :historico_atividades do |t|
      t.references :id_usuario, null: false, foreign_key: { to_table: :usuarios }
      t.string :tipo_acao
      t.string :tipo_entidade
      t.integer :id_entidade
      t.text :descricao
      t.json :alteracoes_antes
      t.json :alteracoes_depois
      t.timestamp :data_criacao

      t.timestamps
    end
    add_index :historico_atividades, :id_usuario_id
    add_index :historico_atividades, :tipo_acao
    add_index :historico_atividades, :tipo_entidade
  end
end
