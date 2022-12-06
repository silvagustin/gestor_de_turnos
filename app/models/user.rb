class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable

  # Associations
  belongs_to :sucursal, optional: true

  enum :rol, { cliente: 0, personal_bancario: 1, administrador: 2 }, scopes: false

  # Scopes
  scope :clientes, ->() { where(rol: :cliente) }
end
