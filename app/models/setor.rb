class Setor < ApplicationRecord
  belongs_to :unidade

  validates :nome_setor, presence: true, length: { minimum: 2, maximum: 100 }
  validates :nome_setor, uniqueness: { case_sensitive: false, scope: :unidade_id }
  validates :unidade_id, presence: true

  before_save :capitalize_nome_setor

  # Método para serialização da API
  def as_json(options = {})
    super(options.merge(
      only: [:id, :nome_setor, :unidade_id, :created_at, :updated_at],
      include: {
        unidade: { only: [:id, :nome_unidade] }
      }
    ))
  end

  private

  def capitalize_nome_setor
    self.nome_setor = nome_setor.titleize if nome_setor.present?
  end
end
