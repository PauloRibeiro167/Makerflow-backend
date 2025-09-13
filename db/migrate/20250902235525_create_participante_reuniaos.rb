class CreateParticipanteReuniaos < ActiveRecord::Migration[8.0]
  def change
    create_table :participante_reuniaos do |t|
      t.references :id_reuniao, null: false, foreign_key: { to_table: :reuniaos }
      t.string :nome_membro
      t.string :papel

      t.timestamps
    end
    add_index :participante_reuniaos, :nome_membro
    add_index :participante_reuniaos, :papel
  end
end
