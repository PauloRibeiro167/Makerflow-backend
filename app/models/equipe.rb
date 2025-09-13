class Equipe < ApplicationRecord
  belongs_to :celula
  has_many :membros_da_equipe, dependent: :destroy

  validates :nome_equipe, presence: true
  validates :celula, presence: true
end
