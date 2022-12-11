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

  private

  def horario_valido?
    horarios_habilitados = sucursal.horarios.habilitados

    if horarios_habilitados.any?
      dias_habilitados = horarios_habilitados.collect(&:dia)
      dia = DIAS[self.horario.wday]

      if dias_habilitados.include?(dia)
        horario_sucursal = horarios_habilitados.find_by(dia: dia)
      else
        errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
        return
      end

      if !((horario_sucursal.hora_inicial..horario_sucursal.hora_final).include?(self.horario.hour)) || (self.horario.hour == horario_sucursal.hora_final && self.horario.min > 0)
        errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
      end
    else
      errors.add(:horario, "no se encuentra dentro de los horarios habilitados")
    end
  end

end