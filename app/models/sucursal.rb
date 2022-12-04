class Sucursal < ApplicationRecord
  # Asociaciones
  has_many :horarios, dependent: :destroy

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true
end
