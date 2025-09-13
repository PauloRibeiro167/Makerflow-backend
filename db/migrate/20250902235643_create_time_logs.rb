class CreateTimeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :time_logs do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :usuarios }
      t.decimal :hours_logged
      t.text :description
      t.date :log_date

      t.timestamps
    end
    add_index :time_logs, :task_id
    add_index :time_logs, :user_id
    add_index :time_logs, :log_date
  end
end
