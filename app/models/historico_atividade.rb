class HistoricoAtividade < ApplicationRecord
  belongs_to :id_usuario, class_name: 'Usuario'
end
