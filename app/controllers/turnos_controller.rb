class TurnosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_turno, only: %i( show edit update destroy )
  before_action -> { authorize_user!(@turno || Turno) }

  def index
    @turnos = policy_scope(Turno)
  end

  def show; end

  def new
    @turno = Turno.new
  end

  def create
    @turno = current_user.turnos.build(turno_params)

    if @turno.save
      redirect_to @turno, notice: 'Turno creado.'
    else
      flash.now[:alert] = 'No se pudo crear el turno'.
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @turno.update(turno_params)
      redirect_to @turno, notice: 'Turno actualizado.'
    else
      flash.now[:alert] = 'No se pudo actualizar el turno.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @turno.destroy
      redirect_to turnos_path, notice: 'Turno eliminado.'
    else
      redirect_to turnos_path, alert: 'No se pudo eliminar la sucursal.'
    end
  end

  private

  def turno_params
    case action_name
    when 'create' then params.require(:turno).permit(:sucursal_id, :motivo)
    when 'update' then params.require(:turno).permit(:respuesta).merge(estado: :atendido, personal_bancario_id: current_user.id)
    end
  end

  def set_turno
    @turno = policy_scope(Turno).find(params[:id])
  end
end