class CreateUnidades < ActiveRecord::Migration[8.0]
  def change
    create_table :unidades do |t|
      t.string :nome_unidade, null: false, limit: 100

      t.timestamps
    end

    add_index :unidades, :nome_unidade, unique: true
  end
end
