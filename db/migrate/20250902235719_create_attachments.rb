class CreateAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :attachments do |t|
      t.references :document, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.string :file_name
      t.string :file_path
      t.integer :file_size
      t.references :uploaded_by_user, null: false, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
    add_index :attachments, :document_id
    add_index :attachments, :task_id
    add_index :attachments, :uploaded_by_user_id
  end
end
