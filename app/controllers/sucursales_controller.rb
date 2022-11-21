class SucursalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sucursal, except: %i( index new create )

  def index
    @sucursales = Sucursal.all
  end

  def show; end

  def new
    @sucursal = Sucursal.new
  end

  def create
    @sucursal = Sucursal.new(sucursal_params)

    if @sucursal.save
      redirect_to @sucursal, notice: "Sucursal '#{@sucursal.nombre}' creada."
    else
      flash.now[:alert] = 'No se pudo crear la sucursal.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sucursal.update(sucursal_params)
      redirect_to @sucursal, notice: "Sucursal '#{@sucursal.nombre}' actualizada."
    else
      flash.now[:alert] = 'No se pudo actualizar la sucursal.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash_message =
      if @sucursal.destroy
        { notice: "Sucursal '#{@sucursal.nombre}' eliminada." }
      else
        { alert: "No se pudo eliminar la sucursal '#{@sucursal.nombre}'. Asegurate que no tenga turnos pendientes" }
      end

    redirect_to sucursales_path, flash_message
  end

  private

  def sucursal_params
    params.require(:sucursal).permit(:nombre, :direccion, :telefono)
  end

  def set_sucursal
    @sucursal = Sucursal.find(params[:id])
  end
end