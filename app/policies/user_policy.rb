class UserPolicy < ApplicationPolicy
  def index?
    @user.administrador?
  end

  def show?
    @user.administrador? || @user.id == current_user.id
  end

  def new?
    @user.administrador?
  end

  def create?
    @user.administrador?
  end

  def edit?
    @user.administrador? || @user.id == current_user.id
  end

  def update?
    @user.administrador? || @user.id == current_user.id
  end

  def destroy?
    @user.administrador?
  end
end