class Sucursal < ApplicationRecord
  # Asociaciones
  has_many :horarios

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true

  # Callbacks
  after_create -> { Horario.crear_horarios(sucursal_id: id) }
end
