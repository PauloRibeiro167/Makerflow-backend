class Sprint < ApplicationRecord
  has_many :relatorios_diarios, class_name: 'RelatorioDiario', dependent: :destroy

  validates :nome_sprint, presence: true
end
