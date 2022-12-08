class User < ApplicationRecord
  # Associations
  belongs_to :sucursal, optional: true

  has_many :turnos, foreign_key: 'cliente_id'
  has_many :sucursales, through: :turnos

  # Include default devise modules
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable

  # Roles
  enum :rol, { cliente: 0, personal_bancario: 1, administrador: 2 }, scopes: false

  # Callbacks
  before_save -> { self.sucursal = nil }, unless: :personal_bancario?

  # Scopes
  scope :clientes, ->() { where(rol: :cliente) }
end
