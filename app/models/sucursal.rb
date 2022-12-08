class Sucursal < ApplicationRecord
  # Asociaciones
  has_many :horarios, dependent: :destroy

  has_many :turnos
  has_many :clientes, through: :turnos

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true
end
