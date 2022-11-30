class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to edit_user_path(current_user), notice: 'Usuario actualizado.'
    else
      flash.now[:alert] = 'No se pudo actualizar el usuario.'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end