class CreateDiagramas < ActiveRecord::Migration[8.0]
  def change
    create_table :diagramas do |t|
      t.references :quadro_kanban, null: false, foreign_key: true
      t.string :nome_arquivo
      t.string :caminho_arquivo
      t.string :tipo_diagrama
      t.date :data_criacao

      t.timestamps
    end
  end
end
