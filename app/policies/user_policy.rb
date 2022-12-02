class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case @user.rol
        when 'administrador'     then User.all
        when 'personal_bancario' then User.clientes
        else                          User.none
      end
    end
  end

  def index?
    @user.administrador? || @user.personal_bancario?
  end

  def show?
    return true if @user.administrador?
    return true if @user.personal_bancario? && @record.cliente?
    return true if @user.id == @record.id
    false
  end

  def new?
    @user.administrador?
  end

  def create?
    @user.administrador?
  end

  def edit?
    return true if @user.administrador?
    return true if @user.id == @record.id
    false
  end

  def update?
    @user.administrador? || @user.id == @record.id
  end

  def destroy?
    @user.administrador?
  end
end