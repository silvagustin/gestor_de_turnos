class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable

  enum :rol, { cliente: 0, personal_bancario: 1, administrador: 2 }, scopes: false
end
