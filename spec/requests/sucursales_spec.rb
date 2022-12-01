require 'rails_helper'
require 'support/session'

RSpec.describe "Sucursales", type: :request do
  let(:sucursal)     { create(:sucursal) }
  let(:create_attrs) { attributes_for(:sucursal) }
  let(:update_attrs) { attributes_for(:sucursal) }

  context 'as a user with CLIENTE rol' do
    include_context :login_cliente_user

    describe 'GET /index' do
      before { get(sucursales_url) }

      it 'should NOT render index page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /show' do
      before { get(sucursal_url(sucursal)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /new' do
      before { get(new_sucursal_url) }

      it 'should NOT render new page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'POST /create' do
      before { post(sucursales_url, params: { sucursal: create_attrs }) }

      it 'should NOT create a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_sucursal_url(sucursal)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_url(sucursal), params: { sucursal: update_attrs }) }

      it 'should NOT update a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(sucursal_url(sucursal)) }

      it 'should NOT destroy a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

  end

  context 'as a user with PERSONAL_BANCARIO rol' do
    include_context :login_personal_bancario_user

    describe 'GET /index' do
      before { get(sucursales_url) }

      it 'should render index page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      before { get(sucursal_url(sucursal)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      before { get(new_sucursal_url) }

      it 'should NOT render new page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'POST /create' do
      before { post(sucursales_url, params: { sucursal: create_attrs }) }

      it 'should NOT create a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_sucursal_url(sucursal)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_url(sucursal), params: { sucursal: update_attrs }) }

      it 'should NOT update a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(sucursal_url(sucursal)) }

      it 'should NOT destroy a sucursal' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

  end

  context 'as a user with ADMINISTRADOR rol' do
    include_context :login_administrador_user

    describe 'GET /index' do
      before { get(sucursales_url) }

      it 'should render index page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      before { get(sucursal_url(sucursal)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      before { get(new_sucursal_url) }

      it 'should render new page' do
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      before { post(sucursales_url, params: { sucursal: create_attrs }) }

      it 'should create a sucursal' do
        expect(flash[:notice]).to eq('Sucursal creada.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'GET /edit' do
      before { get(edit_sucursal_url(sucursal)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'PUT /update' do
      before { put(sucursal_url(sucursal), params: { sucursal: update_attrs }) }

      it 'should update a sucursal' do
        expect(flash[:notice]).to eq('Sucursal actualizada.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'DELETE /destroy' do
      before { delete(sucursal_url(sucursal)) }

      it 'should destroy a sucursal' do
        expect(flash[:notice]).to eq('Sucursal eliminada.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

  end

end