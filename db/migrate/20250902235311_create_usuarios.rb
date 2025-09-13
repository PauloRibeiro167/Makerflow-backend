class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :nome_completo, null: false
      t.date :data_nascimento
      t.string :chave_acesso, null: false
      t.string :email, null: false
      t.string :telefone
      t.string :usuario_git
      t.string :url_foto_perfil
      t.string :role, null: false
      t.string :status, null: false
      t.timestamp :data_criacao
      t.timestamp :ultimo_login

      t.timestamps
    end
    add_index :usuarios, :chave_acesso, unique: true
    add_index :usuarios, :email, unique: true
    add_index :usuarios, :role
    add_index :usuarios, :status
  end
end
