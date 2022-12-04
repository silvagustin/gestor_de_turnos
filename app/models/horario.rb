class Horario < ApplicationRecord
  enum :dia, { lunes: 0, martes: 1, miercoles: 2, jueves: 3, viernes: 4 }

  # Asociaciones
  belongs_to :sucursal

  def self.crear_horarios(sucursal_id:)
    attrs = {
      sucursal_id: sucursal_id,
      dia: nil,
      hora_inicial: 9,
      hora_final: 15,
      habilitado: false
    }

    for dia in self.dia.keys
      attrs[:dia] = dia
      create(attrs)
    end
  end
end
