class CreateRelatorioDiarios < ActiveRecord::Migration[8.0]
  def change
    create_table :relatorio_diarios do |t|
      t.date :data_relatorio
      t.references :sprint, null: false, foreign_key: true
      t.text :pontos_atencao
      t.text :acoes_a_serem_tomadas

      t.timestamps
    end
    add_index :relatorio_diarios, :data_relatorio
  end
end
