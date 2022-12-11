class Sucursal < ApplicationRecord
  # Asociaciones
  has_many :horarios, dependent: :destroy

  has_many :turnos, dependent: :destroy
  has_many :clientes, through: :turnos

  # Callbacks
  before_destroy :puede_eliminarse?, prepend: true

  # Validaciones
  validates :nombre, uniqueness: true
  validates :nombre, :direccion, :telefono, presence: true

  private

  def puede_eliminarse?
    if turnos.pendientes.any?
      errors.add(:base, 'No se puede eliminar la sucursal porque tiene turnos pendientes')
      throw :abort
    end
  end
end