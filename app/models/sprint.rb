class Sprint < ApplicationRecord
  has_many :relatorios_diarios, dependent: :destroy

  validates :nome_sprint, presence: true
end
