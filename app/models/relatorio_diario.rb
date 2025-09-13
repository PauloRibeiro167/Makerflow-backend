class RelatorioDiario < ApplicationRecord
  belongs_to :sprint
  has_many :entradas_trabalho, class_name: 'EntradaTrabalho', dependent: :destroy

  validates :data_relatorio, presence: true
  validates :sprint, presence: true
end
