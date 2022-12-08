class SucursalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case @user.rol
        when 'administrador'     then Sucursal.all
        when 'personal_bancario' then @user.sucursal
        else                          Sucursal.none
      end
    end
  end

  def index?
    true
  end

  def show?
    @user.administrador? || @user.personal_bancario?
  end

  def new?
    @user.administrador?
  end

  def create?
    @user.administrador?
  end

  def edit?
    @user.administrador?
  end

  def update?
    @user.administrador?
  end

  def destroy?
    @user.administrador?
  end
end