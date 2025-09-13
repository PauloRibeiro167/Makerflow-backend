class QuadroKanban < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :documentos_projeto, class_name: 'DocumentoProjeto', dependent: :destroy
  has_many :ativos_projeto, class_name: 'AtivoProjeto', dependent: :destroy
  has_many :diagramas, dependent: :destroy
  has_many :pauta_reuniao, class_name: 'PautaReuniao', dependent: :destroy
  has_many :itens_de_acao, class_name: 'ItemDeAcao', dependent: :destroy
  has_many :riscos, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :entradas_trabalho, class_name: 'EntradaTrabalho', dependent: :destroy

  validates :titulo_tarefa, presence: true
  validates :status_tarefa, presence: true
end
