class SucursalPolicy < ApplicationPolicy
  def index?
    @user.administrador? || @user.personal_bancario?
  end
end