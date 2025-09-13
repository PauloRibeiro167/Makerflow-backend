class CreateSetors < ActiveRecord::Migration[8.0]
  def change
    create_table :setors do |t|
      t.string :nome_setor, null: false, limit: 100
      t.references :unidade, null: false, foreign_key: true

      t.timestamps
    end

    add_index :setors, [:nome_setor, :unidade_id], unique: true
  end
end
