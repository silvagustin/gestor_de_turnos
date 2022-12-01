require 'rails_helper'
require 'support/session'

RSpec.describe "Sucursales", type: :request do
  let(:sucursal) { create(:sucursal) }

  context 'as a user with CLIENTE rol' do
    include_context :login_cliente_user

    describe 'GET /index' do
      before { get(sucursales_url) }

      it 'should NOT render index page' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /show' do
      before { get(sucursal_url(sucursal)) }

      it 'should NOT render show page' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /new' do
      before { get(new_sucursal_url) }

      it 'should NOT render new page' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /create' do
      before { post(sucursales_url, params: { sucursal: attributes_for(:sucursal) }) }

      it 'should NOT create a sucursal' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_sucursal_url(sucursal)) }

      it 'should NOT render edit page' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /update' do
      before { put(sucursal_url(sucursal), params: { sucursal: attributes_for(:sucursal) }) }

      it 'should NOT update a sucursal' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /destroy' do
      before { delete(sucursal_url(sucursal)) }

      it 'should NOT destroy a sucursal' do
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

      it 'should not render new page' do
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /create' do
      before { post(sucursales_url, params: { sucursal: attributes_for(:sucursal) }) }

      it 'should not create a sucursal' do
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_sucursal_url(sucursal)) }

      it 'should not render edit page' do
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /update' do
      before { put(sucursal_url(sucursal), params: { sucursal: attributes_for(:sucursal) }) }

      it 'should not update a sucursal' do
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /destroy' do
      before { delete(sucursal_url(sucursal)) }

      it 'should not destroy a sucursal' do
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

  end

end