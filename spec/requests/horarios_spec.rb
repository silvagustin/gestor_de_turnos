require 'rails_helper'
require 'support/session'

RSpec.describe 'Horarios', type: :request do
  let!(:sucursal) { create(:sucursal, :con_horarios) }
  let!(:horario)  { sucursal.horarios.sample }

  context 'as a NON-logged user' do
    describe 'GET /edit' do
      before { get(edit_sucursal_horario_url(sucursal, horario)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_horario_url(sucursal, horario)) }

      it 'should NOT update a horario' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

  end

  context 'as a user with CLIENTE role' do
    include_context :login_cliente_user

    describe 'GET /edit' do
      before { get(edit_sucursal_horario_url(sucursal, horario)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_horario_url(sucursal, horario)) }

      it 'should NOT update a horario' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

  end

  context 'as a user with PERSONAL_BANCARIO role' do
    include_context :login_personal_bancario_user

    describe 'GET /edit' do
      before { get(edit_sucursal_horario_url(sucursal, horario)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_horario_url(sucursal, horario)) }

      it 'should NOT update a horario' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

  end

  context 'as a user with ADMINISTRADOR role' do
    include_context :login_administrador_user

    let(:valid_update_params)   { { horario: { hora_inicial: 10, hora_final: 12, habilitado: true } } }
    let(:invalid_update_params) { { horario: { hora_inicial: 9999, hora_final: 'qwerty', habilitado: true } } }

    describe 'GET /edit' do
      before { get(edit_sucursal_horario_url(sucursal, horario)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'PUT /update with valid attributes' do
      before { put(sucursal_horario_url(sucursal, horario), params: valid_update_params) }

      it 'should update horario' do
        expect(flash[:notice]).to eq('Horario actualizado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'PUT /update with invalid attributes' do
      before { put(sucursal_horario_url(sucursal, horario), params: invalid_update_params) }

      it 'should NOT update horario' do
        expect(flash[:alert]).to eq('No se pudo actualizar el horario.')
        expect(response.redirect_url).to eq(nil)
      end

    end

  end

end