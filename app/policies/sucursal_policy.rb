class SucursalPolicy < ApplicationPolicy
  def index?
    @user.administrador? || @user.personal_bancario?
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