class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :priority
      t.string :status, null: false
      t.date :start_date
      t.date :due_date
      t.timestamp :completed_at
      t.references :quadro_kanban, null: false, foreign_key: true
      t.references :parent_task, foreign_key: { to_table: :tasks }
      t.boolean :is_macro_task
      t.references :user, null: false, foreign_key: { to_table: :usuarios }
      t.decimal :estimated_effort
      t.references :assignee, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
    add_index :tasks, :status
    add_index :tasks, :priority
    add_index :tasks, :quadro_kanban_id
    add_index :tasks, :user_id
    add_index :tasks, :assignee_id
    add_index :tasks, :parent_task_id
  end
end
