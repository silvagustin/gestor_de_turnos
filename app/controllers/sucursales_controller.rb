class SucursalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sucursal, except: %i( index new create )

  def index
    @sucursales = Sucursal.all
    flash[:notice] = 'hola mundo'
    flash[:alert] = 'alerta'
  end

  def show; end

  def new
    @sucursal = Sucursal.new
  end

  def create
    @sucursal = Sucursal.new(sucursal_params)

    if @sucursal.save
      redirect_to @sucursal, notice: 'Sucursal creada.'
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy
    @sucursal.destroy
    redirect_to sucursales_path
  end

  private

  def sucursal_params
    params.require(:sucursal).permit(:nombre, :direccion, :telefono)
  end

  def set_sucursal
    @sucursal = Sucursal.find(params[:id])
  end
end