class AtivoProjeto < ApplicationRecord
  belongs_to :quadro_kanban

  validates :quadro_kanban, presence: true
  validates :tipo_ativo, presence: true
end
