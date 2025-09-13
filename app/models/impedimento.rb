class Impedimento < ApplicationRecord
  belongs_to :id_entry, class_name: 'EntradaTrabalho'
end
