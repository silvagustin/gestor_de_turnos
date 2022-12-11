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
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Usuario creado.'
    else
      flash.now[:alert] = 'No se pudo crear el usuario.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user) if current_user.id == @user.id
      redirect_to edit_user_path(@user), notice: 'Usuario actualizado.'
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
    case [current_user.rol, action_name]
    in ['administrador', 'create']
      permitted_params([:email, :rol, :sucursal_id, :password, :password_confirmation])
     in ['administrador', 'update'] if cambio_de_password?
      permitted_params([:email, :rol, :sucursal_id, :password, :password_confirmation])
    in ['administrador', 'update']
      permitted_params([:email, :sucursal_id, :rol])
    else
      permitted_params([:password, :password_confirmation])
    end
  end

  def permitted_params(fields)
    params.require(:user).permit(*fields)
  end

  def cambio_de_password?
    params[:user][:password].present? || params[:user][:password_confirmation].present?
  end

  def set_user
    @user = User.find(params[:id])
  end
end