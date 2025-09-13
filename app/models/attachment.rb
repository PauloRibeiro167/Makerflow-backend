class Attachment < ApplicationRecord
  belongs_to :document
  belongs_to :task
  belongs_to :uploaded_by_user, class_name: 'Usuario'
end
