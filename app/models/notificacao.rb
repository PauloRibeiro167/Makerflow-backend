class Notificacao < ApplicationRecord
  belongs_to :id_usuario_destinatario, class_name: 'Usuario'
  belongs_to :id_usuario_remetente, class_name: 'Usuario'
end
