class CreateDocumentoProjetos < ActiveRecord::Migration[8.0]
  def change
    create_table :documento_projetos do |t|
      t.references :quadro_kanban, null: false, foreign_key: true
      t.string :tipo_documento, null: false
      t.string :caminho_documento
      t.text :anotacoes

      t.timestamps
    end
    add_index :documento_projetos, :tipo_documento
    add_index :documento_projetos, :quadro_kanban_id
  end
end
