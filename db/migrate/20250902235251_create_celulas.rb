class CreateCelulas < ActiveRecord::Migration[8.0]
  def change
    create_table :celulas do |t|
      t.string :nome_celula, null: false
      t.references :setor, null: false, foreign_key: true

      t.timestamps
    end
    add_index :celulas, :nome_celula
    add_index :celulas, :setor_id
  end
end
