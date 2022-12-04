class HorariosController < ApplicationController
  before_action :authenticate_user!
  before_action -> { authorize_user!(@horario || Horario) }
  before_action :set_horario, only: %i{ edit update }

  private

  def set_horario
    # @horario = Horario.find(params[:id])
    @horario = nil
    # @horario = Horario.find_by(id: params[:id], sucursal_id: params[:sucursal_id])
  end
end