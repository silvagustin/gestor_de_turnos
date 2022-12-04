class Horario < ApplicationRecord
  enum :dia, { lunes: 0, martes: 1, miercoles: 2, jueves: 3, viernes: 4 }

  # Asociaciones
  belongs_to :sucursal

  # Validaciones
  validates_associated :sucursal

  validates :habilitado, inclusion: { in: [true, false] }

  validates :hora_inicial,
            :hora_final,
            numericality: {
              greater_than_or_equal_to: 9,
              less_than_or_equal_to: 15,
              only_integer: true
            }

  validate :hora_inicial_es_menor_que_hora_final

  def self.crear_horarios(sucursal_id:)
    begin
      sucursal_id = Integer(sucursal_id)
      self.dia.keys.each { |dia| create(sucursal_id: sucursal_id, dia: dia) }
    rescue TypeError, ArgumentError
      return "'sucursal_id' debe ser un numero entero"
    end
  end

  private

  def hora_inicial_es_menor_que_hora_final
    return if !hora_inicial.present? || !hora_final.present?

    if hora_inicial >= hora_final
      errors.add(:hora_inicial, "'hora_inicial' debe ser MENOR a 'hora_final'")
    end
  end

end
