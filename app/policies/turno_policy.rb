class TurnoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case @user.rol
      when 'personal_bancario' then @user.sucursal.turnos
      when 'cliente'           then @user.turnos
      else Turno.none
      end
    end
  end

  def index?
    @user.cliente? || @user.personal_bancario?
  end

  def show?
    return true if @user.cliente? && @user.id == @record.cliente_id
    return true if @user.personal_bancario? && @user.sucursal_id == @record.sucursal_id
    false
  end

  def new?
    @user.cliente?
  end

  def create?
    @user.cliente?
  end

  def edit?
    @user.personal_bancario? && @record.pendiente? && @user.sucursal_id == @record.sucursal_id
  end

  def update?
    @user.personal_bancario? && @record.pendiente? && @user.sucursal_id == @record.sucursal_id
  end

  def destroy?
    @user.cliente? && @record.pendiente? && @user.id == @record.cliente_id
  end

end