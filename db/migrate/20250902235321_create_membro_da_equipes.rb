class CreateMembroDaEquipes < ActiveRecord::Migration[8.0]
  def change
    create_table :membro_da_equipes do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :equipe, null: false, foreign_key: true
      t.date :data_adesao

      t.timestamps
    end
    add_index :membro_da_equipes, [:usuario_id, :equipe_id], unique: true
  end
end
