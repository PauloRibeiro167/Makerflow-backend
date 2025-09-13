class DocumentoProjeto < ApplicationRecord
  belongs_to :quadro_kanban

  validates :quadro_kanban, presence: true
  validates :tipo_documento, presence: true
end
