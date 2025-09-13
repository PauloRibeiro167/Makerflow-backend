class CreateNotificacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :notificacaos do |t|
      t.references :id_usuario_destinatario, null: false, foreign_key: { to_table: :usuarios }
      t.references :id_usuario_remetente, null: false, foreign_key: { to_table: :usuarios }
      t.string :tipo_notificacao
      t.text :mensagem
      t.string :link_relacionado
      t.integer :id_entidade_relacionada
      t.boolean :lida
      t.boolean :arquivada
      t.timestamp :data_criacao

      t.timestamps
    end
    add_index :notificacaos, :id_usuario_destinatario_id
    add_index :notificacaos, :id_usuario_remetente_id
    add_index :notificacaos, :lida
    add_index :notificacaos, :arquivada
  end
end
