class Equipe < ApplicationRecord
  belongs_to :celula
  has_many :membros_da_equipe, class_name: 'MembroDaEquipe', dependent: :destroy

  validates :nome_equipe, presence: true
  validates :celula, presence: true
end
