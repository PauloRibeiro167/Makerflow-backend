class Automation < ApplicationRecord
  validates :name, presence: true
  validates :trigger_event, presence: true
  validates :action_type, presence: true
  validates :is_active, inclusion: { in: [true, false] }
end
