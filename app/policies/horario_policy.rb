class HorarioPolicy < ApplicationPolicy
  def edit?
    @user.administrador?
  end

  def update?
    @user.administrador?
  end
end