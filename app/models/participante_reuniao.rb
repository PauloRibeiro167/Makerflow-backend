class ParticipanteReuniao < ApplicationRecord
  belongs_to :id_reuniao, class_name: 'Reuniao'
end
