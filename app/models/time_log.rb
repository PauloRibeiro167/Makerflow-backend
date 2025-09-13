class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :user, class_name: 'Usuario'
end
