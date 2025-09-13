class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.references :quadro_kanban, null: false, foreign_key: true
      t.references :parent_document, foreign_key: { to_table: :documents }
      t.references :created_by_user, null: false, foreign_key: { to_table: :usuarios }
      t.references :last_edited_by_user, null: false, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
  end
end
