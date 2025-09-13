class CreateEquipes < ActiveRecord::Migration[8.0]
  def change
    create_table :equipes do |t|
      t.string :nome_equipe, null: false
      t.references :celula, null: false, foreign_key: true

      t.timestamps
    end
    add_index :equipes, :nome_equipe
    add_index :equipes, :celula_id
  end
end
