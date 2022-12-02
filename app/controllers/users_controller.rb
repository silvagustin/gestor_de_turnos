class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: %i( index new create )
  before_action -> { authorize_user!(@user || User) }

  def index
    @users = policy_scope(User)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    if @user = User.create(user_params)
      redirect_to @user, notice: 'Usuario creado.'
    else
      flash.now[:alert] = 'No se pudo crear el usuario.'
      render :new, status: :unprocessable_entity
    end
  end

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

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'Usuario eliminado.'
    else
      redirect_to users_path, alert: 'No se pudo eliminar el usuario.'
    end
  end

  private

  def user_params
    if current_user.administrador?
      params.require(:user).permit(:email, :rol, :password, :password_confirmation)
    else
      params.require(:user).permit(:password, :password_confirmation)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end