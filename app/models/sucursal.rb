class Sucursal < ApplicationRecord
  # Asociaciones
  has_many :horarios

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true
end
