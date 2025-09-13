class CreateAutomations < ActiveRecord::Migration[8.0]
  def change
    create_table :automations do |t|
      t.string :name
      t.text :description
      t.string :trigger_event
      t.json :trigger_data
      t.string :action_type
      t.json :action_data
      t.boolean :is_active

      t.timestamps
    end
    add_index :automations, :name
    add_index :automations, :trigger_event
    add_index :automations, :is_active
  end
end
