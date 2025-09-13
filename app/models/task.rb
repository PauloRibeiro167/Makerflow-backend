class Task < ApplicationRecord
  belongs_to :quadro_kanban
  belongs_to :parent_task, class_name: 'Task', optional: true
  belongs_to :user, class_name: 'Usuario'
  belongs_to :assignee, class_name: 'Usuario', optional: true

  has_many :sub_tasks, class_name: 'Task', foreign_key: 'parent_task_id', dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :attachments, dependent: :destroy

  validates :title, presence: true
  validates :status, presence: true
  validates :quadro_kanban, presence: true
  validates :user, presence: true
end
