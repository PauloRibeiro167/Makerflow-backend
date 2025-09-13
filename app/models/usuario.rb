class Usuario < ApplicationRecord
  belongs_to :role
  has_many :membros_da_equipe, dependent: :destroy
  has_many :user_projects
  has_many :projetos, through: :user_projects

  has_secure_token :chave_acesso

  validates :nome_completo, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :chave_acesso, presence: true, uniqueness: true
  validates :role, presence: true
  validates :status, presence: true
end
