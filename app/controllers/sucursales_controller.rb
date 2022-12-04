class SucursalesController < ApplicationController
  before_action :authenticate_user!
  before_action -> { authorize_user!(Sucursal) }
  before_action :set_sucursal, except: %i( index new create )

  def index
    @sucursales = Sucursal.all
  end

  def show; end

  def new
    @sucursal = Sucursal.new
  end

  def create
    if @sucursal = Sucursal.create(sucursal_params)
      Horario.crear_horarios(sucursal_id: @sucursal.id)
      redirect_to @sucursal, notice: 'Sucursal creada.'
    else
      flash.now[:alert] = 'No se pudo crear la sucursal.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sucursal.update(sucursal_params)
      redirect_to @sucursal, notice: 'Sucursal actualizada.'
    else
      flash.now[:alert] = 'No se pudo actualizar la sucursal.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @sucursal.destroy
      redirect_to sucursales_path, notice: 'Sucursal eliminada.'
    else
      redirect_to sucursales_path, alert: 'No se pudo eliminar la sucursal.'
    end
  end

  private

  def sucursal_params
    params.require(:sucursal).permit(:nombre, :direccion, :telefono)
  end

  def set_sucursal
    @sucursal = Sucursal.find(params[:id])
  end

  def authorized?
    super(Sucursal)
  end
end