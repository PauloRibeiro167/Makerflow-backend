class UserProject < ApplicationRecord
  belongs_to :usuario
  belongs_to :projeto
  belongs_to :role
end
