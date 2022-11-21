class Horario < ApplicationRecord
  enum :dia, { lunes: 0, martes: 1, miercoles: 2, jueves: 3, viernes: 4 }

  belongs_to :sucursal
end
