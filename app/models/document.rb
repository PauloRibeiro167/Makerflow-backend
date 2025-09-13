class Document < ApplicationRecord
  belongs_to :project, class_name: 'Projeto'
  belongs_to :parent_document, class_name: 'Document'
  belongs_to :created_by_user, class_name: 'Usuario'
  belongs_to :last_edited_by_user, class_name: 'Usuario'
end
