class Reuniao < ApplicationRecord
  belongs_to :id_sprint, class_name: 'Sprint'
end
