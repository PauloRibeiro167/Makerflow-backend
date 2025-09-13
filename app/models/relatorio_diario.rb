class RelatorioDiario < ApplicationRecord
  belongs_to :sprint
  has_many :entradas_trabalho, dependent: :destroy

  validates :data_relatorio, presence: true
  validates :sprint, presence: true
end
