class Document < ApplicationRecord
  belongs_to :project
  belongs_to :parent_document
  belongs_to :created_by_user
  belongs_to :last_edited_by_user
end
