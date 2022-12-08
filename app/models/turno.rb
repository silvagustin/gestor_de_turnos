class Turno < ApplicationRecord
  # Asociaciones
  belongs_to :cliente, class_name: 'User'
  belongs_to :sucursal

  belongs_to :personal_bancario, class_name: 'User', optional: true

  # Validaciones
  validates_associated :cliente, :sucursal, on: :create
  validates :motivo, :horario, presence: true, on: :create
  validates :respuesta, presence: true, on: :update

  # Estados
  enum :estado, { pendiente: 0, atendido: 1 }
end