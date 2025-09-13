class Role < ApplicationRecord
  has_many :usuarios
  has_many :user_projects

  validates :name, presence: true, uniqueness: true
end
