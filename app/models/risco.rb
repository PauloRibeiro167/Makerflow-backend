class Risco < ApplicationRecord
  belongs_to :id_projeto, class_name: 'QuadroKanban'
  belongs_to :id_responsavel, class_name: 'Usuario'
end
