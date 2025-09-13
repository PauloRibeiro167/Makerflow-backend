class ItemDeAcao < ApplicationRecord
  belongs_to :id_reuniao, class_name: 'Reuniao'
  belongs_to :id_kanban, class_name: 'QuadroKanban'
end
