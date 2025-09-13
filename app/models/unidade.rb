class Unidade < ApplicationRecord
  validates :nome_unidade, presence: true, length: { minimum: 2, maximum: 100 }
  validates :nome_unidade, uniqueness: { case_sensitive: false }

  before_save :capitalize_nome_unidade

  # Método para serialização da API
  def as_json(options = {})
    super(options.merge(
      only: [:id, :nome_unidade, :created_at, :updated_at]
    ))
  end

  private

  def capitalize_nome_unidade
    self.nome_unidade = nome_unidade.titleize if nome_unidade.present?
  end
end
