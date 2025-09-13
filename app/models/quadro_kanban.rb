class QuadroKanban < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :documentos_projeto, dependent: :destroy
  has_many :ativos_projeto, dependent: :destroy
  has_many :diagramas, dependent: :destroy
  has_many :pauta_reuniao, dependent: :destroy
  has_many :itens_de_acao, dependent: :destroy
  has_many :riscos, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :entradas_trabalho, dependent: :destroy

  validates :titulo_tarefa, presence: true
  validates :status_tarefa, presence: true
end
