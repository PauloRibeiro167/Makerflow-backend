class Celula < ApplicationRecord
  belongs_to :setor
  has_many :equipes, dependent: :destroy

  validates :nome_celula, presence: true
  validates :setor, presence: true
end
