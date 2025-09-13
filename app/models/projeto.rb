class Projeto < ApplicationRecord
  has_many :user_projects
  has_many :usuarios, through: :user_projects
  has_many :roles, through: :user_projects

  validates :nome, presence: true
end
