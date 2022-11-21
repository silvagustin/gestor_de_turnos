class SucursalBancaria < ApplicationRecord
  # La convención de Rails no se lleva muy bien con el español y debo setear
  # la tabla a la que debe apuntar el modelo.
  self.table_name = 'sucursales_bancarias'

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true
end
