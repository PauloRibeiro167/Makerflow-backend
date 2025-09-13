class CreateQuadroKanbans < ActiveRecord::Migration[8.0]
  def change
    create_table :quadro_kanbans do |t|
      t.string :titulo_tarefa, null: false
      t.text :descricao
      t.string :status_tarefa, null: false
      t.date :data_vencimento
      t.date :data_inicio
      t.date :data_prioridade
      t.string :tipo_tarefa
      t.string :responsavel
      t.text :comentarios

      t.timestamps
    end
    add_index :quadro_kanbans, :status_tarefa
    add_index :quadro_kanbans, :tipo_tarefa
    add_index :quadro_kanbans, :responsavel
  end
end
