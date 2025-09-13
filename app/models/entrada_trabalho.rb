class EntradaTrabalho < ApplicationRecord
  belongs_to :relatorio_diario
  belongs_to :quadro_kanban

  validates :relatorio_diario, presence: true
  validates :quadro_kanban, presence: true
  validates :reportado_por, presence: true
end
