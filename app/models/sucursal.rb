class Sucursal < ApplicationRecord
  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true
end
