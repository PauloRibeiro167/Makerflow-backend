class CreateAtivoProjetos < ActiveRecord::Migration[8.0]
  def change
    create_table :ativo_projetos do |t|
      t.references :quadro_kanban, null: false, foreign_key: true
      t.string :tipo_ativo, null: false
      t.string :caminho_ativo
      t.text :descricao_ativo

      t.timestamps
    end
    add_index :ativo_projetos, :tipo_ativo
    add_index :ativo_projetos, :quadro_kanban_id
  end
end
