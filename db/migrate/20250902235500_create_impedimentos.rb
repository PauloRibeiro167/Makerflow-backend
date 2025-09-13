class CreateImpedimentos < ActiveRecord::Migration[8.0]
  def change
    create_table :impedimentos do |t|
      t.references :id_entry, null: false, foreign_key: { to_table: :entrada_trabalhos }
      t.text :descricao_impedimento
      t.string :status_impedimento
      t.string :categoria_impedimento
      t.string :responsavel_impedimento
      t.text :notas_resolucao

      t.timestamps
    end
    add_index :impedimentos, :status_impedimento
    add_index :impedimentos, :categoria_impedimento
  end
end
