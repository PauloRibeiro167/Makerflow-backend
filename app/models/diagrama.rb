class Diagrama < ApplicationRecord
  belongs_to :id_kanban, class_name: 'QuadroKanban'
end
