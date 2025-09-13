class CreateRiscos < ActiveRecord::Migration[8.0]
  def change
    create_table :riscos do |t|
      t.references :id_projeto, null: false, foreign_key: { to_table: :quadro_kanbans }
      t.string :titulo_risco
      t.text :descricao
      t.string :probabilidade
      t.string :impacto
      t.integer :pontuacao_criticidade
      t.string :status_risco
      t.text :plano_mitigacao
      t.references :id_responsavel, null: false, foreign_key: { to_table: :usuarios }
      t.timestamp :data_criacao
      t.timestamp :data_resolucao
      t.timestamp :data_atualizacao

      t.timestamps
    end
    add_index :riscos, :id_projeto_id
    add_index :riscos, :id_responsavel_id
    add_index :riscos, :status_risco
    add_index :riscos, :probabilidade
  end
end
