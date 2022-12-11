class Turno < ApplicationRecord
  # Constantes
  DIAS = {
    1 => "lunes",
    2 => "martes",
    3 => "miercoles",
    4 => "jueves",
    5 => "viernes"
  }

  # Asociaciones
  belongs_to :cliente, class_name: 'User'
  belongs_to :sucursal

  belongs_to :personal_bancario, class_name: 'User', optional: true

  # Validaciones
  validates_associated :cliente, :sucursal, on: :create
  validates :motivo, :horario, presence: true, on: :create
  validates :respuesta, presence: true, on: :update

  validate :horario_valido?, on: :create

  # Estados
  enum :estado, { pendiente: 0, atendido: 1 }

  # Scopes
  scope :pendientes, -> { where(estado: :pendiente) }

  private

  def horario_valido?
    if horarios_habilitados = verificar_sucursal_horarios_habilitados
      dia = DIAS[self.horario&.wday]

      es_valido = verificar_dia_incluido_en_horarios_habilitados(dia, horarios_habilitados)
      return unless es_valido

      es_valido = verificar_si_fecha_esta_en_el_pasado
      return unless es_valido

      horario_sucursal = horarios_habilitados.find_by(dia: dia)
      es_valido = verificar_hora(horario_sucursal)
      return unless es_valido

      es_valido = verificar_minutos(horario_sucursal)
    end
  end

  def verificar_sucursal_horarios_habilitados
    horarios_habilitados = sucursal&.horarios&.habilitados

    return horarios_habilitados if horarios_habilitados&.any?
    errors.add(:base, "la sucursal no tiene horarios habilitados")
    false
  end

  def verificar_dia_incluido_en_horarios_habilitados(dia, horarios_habilitados)
    dias_habilitados = horarios_habilitados.collect(&:dia)

    return true if dias_habilitados.include?(dia)
    errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
    false
  end

  def verificar_si_fecha_esta_en_el_pasado
    return true if horario > Time.now
    errors.add(:horario, 'no puede ser una fecha del pasado')
    false
  end

  def verificar_hora(horario_sucursal)
    return true if (horario_sucursal.hora_inicial..horario_sucursal.hora_final).include?(horario.hour)
    errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
    false
  end

  def verificar_minutos(horario_sucursal)
    return true if !(horario.hour == horario_sucursal.hora_final && horario.min > 0)
    errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
    false
  end

end