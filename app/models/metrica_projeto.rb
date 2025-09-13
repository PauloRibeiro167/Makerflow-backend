class MetricaProjeto < ApplicationRecord
  belongs_to :id_projeto, class_name: 'QuadroKanban'
  belongs_to :id_sprint, class_name: 'Sprint'
  belongs_to :id_equipe, class_name: 'Equipe'
end
