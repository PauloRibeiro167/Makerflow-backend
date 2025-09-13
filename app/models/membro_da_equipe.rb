class MembroDaEquipe < ApplicationRecord
  belongs_to :usuario
  belongs_to :equipe

  validates :usuario, presence: true
  validates :equipe, presence: true
  validates :usuario_id, uniqueness: { scope: :equipe_id, message: "já é membro desta equipe" }
end
