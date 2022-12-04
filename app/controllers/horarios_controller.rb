class HorariosController < ApplicationController
  before_action :authenticate_user!
  before_action -> { authorize_user!(@horario) }
  before_action :set_horario, only: %i{ edit update }

  def edit; end

  def update
    if @horario.update(horario_params)
      redirect_to sucursal_path(@horario.sucursal), notice: 'Horario actualizado.'
    else
      flash.now[:alert] = 'No se pudo actualizar el horario'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def horario_params
    params.require(:horario).permit(:hora_inicial, :hora_final, :habilitado)
  end

  def set_horario
    @horario = Horario.where(sucursal_id: params[:sucursal_id])
                      .find(params[:id])
  end
end