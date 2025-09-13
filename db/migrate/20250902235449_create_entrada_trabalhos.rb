class CreateEntradaTrabalhos < ActiveRecord::Migration[8.0]
  def change
    create_table :entrada_trabalhos do |t|
      t.references :relatorio_diario, null: false, foreign_key: true
      t.references :quadro_kanban, null: false, foreign_key: true
      t.string :reportado_por
      t.text :o_que_foi_feito
      t.text :o_que_sera_feito

      t.timestamps
    end
    add_index :entrada_trabalhos, :relatorio_diario_id
    add_index :entrada_trabalhos, :quadro_kanban_id
  end
end
