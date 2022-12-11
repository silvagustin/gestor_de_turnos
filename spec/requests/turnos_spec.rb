require 'rails_helper'
require 'support/session'

RSpec.describe 'Turnos', type: :request do
  context 'as a NON-logged user' do
    let(:turno) { create(:turno) }

    describe 'GET /index' do
      before { get(turnos_url) }

      it 'should NOT render index page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /show' do
      before { get(turno_url(turno)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE /destroy' do
      before { delete(turno_url(turno)) }

      it 'should NOT destroy a turno' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

  end

  context 'as a user with CLIENTE rol' do
    include_context :login_cliente_user

    let(:turno_1) { create(:turno, cliente_id: @cliente_user.id) }
    let(:turno_2) { create(:turno) }

    describe 'GET /index' do
      before { get(turnos_url) }

      it 'should render index page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'should render show page' do
        get(turno_url(turno_1))
        expect(response).to be_successful
      end

      it 'should NOT render show page when turno is from another user' do
        get(turno_url(turno_2))
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'DELETE /destroy' do
      it 'should destroy a turno' do
        delete(turno_url(turno_1))
        expect(flash[:notice]).to eq('Turno eliminado.')
        expect(response).to redirect_to(turnos_url)
      end

      it 'should NOT destroy a turno when is from another user' do
        delete(turno_url(turno_2))
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

  end

  context 'as a user with PERSONAL_BANCARIO rol' do
    include_context :login_personal_bancario_user

    let(:turno)   { create(:turno) }

    describe 'GET /index' do
      before { get(turnos_url) }

      it 'should render index page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'should render show page when turno has the same sucursal as personal_bancario_user' do
        Horario.crear_horarios(sucursal_id: @personal_bancario_user.sucursal_id)
        @personal_bancario_user.sucursal.horarios.update_all(habilitado: true)
        turno = create(:turno, sucursal_id: @personal_bancario_user.sucursal_id)
        get(turno_url(turno))
        expect(response).to be_successful
      end

      it 'should NOT render show page when turno has NOT the same sucursal as personal_bancario_user' do
        get(turno_url(turno))
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(turno_url(turno)) }

      it 'should NOT destroy a turno' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

  end

  context 'as a user with ADMINISTRADOR rol' do
    include_context :login_administrador_user

    let(:turno) { create(:turno) }

    describe 'GET /index' do
      before { get(turnos_url) }

      it 'should NOT render index page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'GET /show' do
      before { get(turno_url(turno)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(turno_url(turno)) }

      it 'should NOT destroy a turno' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

  end

end