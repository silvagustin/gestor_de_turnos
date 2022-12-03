require 'rails_helper'
require 'support/session'

# TODOs:
# - Revisar specs:
  # - [] non-logged user
  # - [] cliente user
  # - [] personal_bancario user
  # - [] administrador user

# - En el controller, tener en cuenta que el edit esta aceptando el email como parametro... habria que cambiar los tests de update de administrador user. Saaaalvo que permitamos esto solo para administradores

RSpec.describe 'Users', type: :request do
  let!(:cliente_user)           { create(:user) }
  let!(:administrador_user)     { create(:user, :administrador) }
  let!(:personal_bancario_user) { create(:user, :personal_bancario) }

  let(:create_attrs)         { attributes_for(:user) }
  let(:valid_update_attrs)   { { password: 'qwerty', password_confirmation: 'qwerty' } }
  let(:invalid_update_attrs) { { password: 'qwerty', password_confirmation: '123123' } }

  context 'as a NON-logged user' do
    describe 'GET /index' do
      before { get(users_url) }

      it 'should NOT render index page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /show' do
      before { get(user_url(cliente_user)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /new' do
      before { get(new_user_url) }

      it 'should NOT render new page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST /create' do
      before { post(users_url, params: { user: create_attrs }) }

      it 'should NOT create a user' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET /edit' do
      before { get(edit_user_url(cliente_user)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PUT /update' do
      before { put(user_url(cliente_user), params: { user: valid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE /destroy' do
      before { delete(user_url(cliente_user)) }

      it 'should NOT destroy a user' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        expect(response).to redirect_to(new_user_session_url)
      end
    end

  end

  context 'as a user with CLIENTE role' do
    include_context :login_cliente_user

    describe 'GET /index' do
      before { get(users_url) }

      it 'should NOT render index page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /show' do
      before { get(user_url(@cliente_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user' do
      before { get(user_url(cliente_user)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /new' do
      before { get(new_user_url) }

      it 'should NOT render new page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'POST /create' do
      before { post(users_url, params: { user: create_attrs }) }

      it 'should NOT create a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_user_url(@cliente_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /edit with another user' do
      before { get(edit_user_url(cliente_user)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'PUT /update with valid attributes' do
      before { put(user_url(@cliente_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'PUT /update with invalid attributes' do
      before { put(user_url(@cliente_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'PUT /update with another user' do
      before { put(user_url(cliente_user), params: { user: valid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(user_url(@cliente_user)) }

      it 'should NOT destroy a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

    describe 'DELETE /destroy with another user' do
      before { delete(user_url(cliente_user)) }

      it 'should NOT destroy a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end
    end

  end

  context 'as a user with PERSONAL BANCARIO role' do
    include_context :login_personal_bancario_user

    describe 'GET /index' do
      before { get(users_url) }

      it 'should render index page ONLY with users with CLIENTE role' do
        expect(response).to be_successful
        expect(response.body).to include(cliente_user.email)
        expect(response.body).not_to include(administrador_user.email, personal_bancario_user.email)
      end
    end

    describe 'GET /show' do
      before { get(user_url(@personal_bancario_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user with CLIENTE role' do
      before { get(user_url(cliente_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user with PERSONAL BANCARIO role' do
      before { get(user_url(personal_bancario_user)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /show with another user with ADMINISTRADOR role' do
      before { get(user_url(administrador_user)) }

      it 'should NOT render show page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /new' do
      before { get(new_user_url) }

      it 'should NOT render new page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'POST /create' do
      before { post(users_url, params: { user: create_attrs }) }

      it 'should NOT create a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'GET /edit' do
      before { get(edit_user_url(@personal_bancario_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /edit with another user' do
      before { get(edit_user_url(cliente_user)) }

      it 'should NOT render edit page' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'PUT /update with valid attributes' do
      before { put(user_url(@personal_bancario_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'PUT /update with invalid attributes' do
      before { put(user_url(@personal_bancario_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'PUT /update with another user' do
      before { put(user_url(cliente_user), params: { user: valid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'DELETE /destroy' do
      before { delete(user_url(@personal_bancario_user)) }

      it 'should NOT destroy a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

    describe 'DELETE /destroy with another user' do
      before { delete(user_url(cliente_user)) }

      it 'should NOT destroy a user' do
        expect(flash[:alert]).to eq('No tiene suficientes permisos para realizar esta operacion.')
        expect(response).to redirect_to(edit_user_url(@personal_bancario_user))
      end
    end

  end

  context 'as a user with ADMINISTRADOR role' do
    include_context :login_administrador_user

    describe 'GET /index' do
      before { get(users_url) }

      it 'should render index page' do
        expect(response).to be_successful

        emails = [
          @administrador_user.email,
          administrador_user.email,
          personal_bancario_user.email,
          cliente_user.email
        ]

        expect(response.body).to include(*emails)
      end
    end

    describe 'GET /show' do
      before { get(user_url(@administrador_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user with CLIENTE role' do
      before { get(user_url(cliente_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user with PERSONAL BANCARIO role' do
      before { get(user_url(personal_bancario_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /show with another user with ADMINISTRADOR role' do
      before { get(user_url(administrador_user)) }

      it 'should render show page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      before { get(new_user_url) }

      it 'should render new page' do
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      before { post(users_url, params: { user: create_attrs }) }

      it 'should create a user' do
        expect(flash[:notice]).to eq('Usuario creado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'GET /edit' do
      before { get(edit_user_url(@administrador_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /edit with another user with CLIENTE role' do
      before { get(edit_user_url(cliente_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /edit with another user with PERSONAL_BANCARIO role' do
      before { get(edit_user_url(personal_bancario_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'GET /edit with another user with ADMINISTRADOR role' do
      before { get(edit_user_url(administrador_user)) }

      it 'should render edit page' do
        expect(response).to be_successful
      end
    end

    describe 'PUT /update with all valid attributes' do
      before { put(user_url(@administrador_user), params: { user: attributes_for(:user) }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with valid attributes' do
      before { put(user_url(@administrador_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with invalid attributes' do
      before { put(user_url(@administrador_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'PUT /update with all valid attributes to another user with CLIENTE role' do
      before { put(user_url(cliente_user), params: { user: attributes_for(:user) }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with valid attributes to another user with CLIENTE role' do
      before { put(user_url(cliente_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with invalid attributes to another user with CLIENTE role' do
      before { put(user_url(cliente_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'PUT /update with all valid attributes to another user with PERSONAL_BANCARIO role' do
      before { put(user_url(personal_bancario_user), params: { user: attributes_for(:user) }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with valid attributes to another user with PERSONAL_BANCARIO role' do
      before { put(user_url(personal_bancario_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with invalid attributes to another user with PERSONAL_BANCARIO role' do
      before { put(user_url(personal_bancario_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'PUT /update with all valid attributes to another user with ADMINISTRADOR role' do
      before { put(user_url(administrador_user), params: { user: attributes_for(:user) }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with valid attributes to another user with ADMINISTRADOR role' do
      before { put(user_url(administrador_user), params: { user: valid_update_attrs }) }

      it 'should update a user' do
        expect(flash[:notice]).to eq('Usuario actualizado.')
        expect(response).to redirect_to(edit_user_url(@administrador_user))
      end
    end

    describe 'PUT /update with invalid attributes to another user with CLIENTE role' do
      before { put(user_url(administrador_user), params: { user: invalid_update_attrs }) }

      it 'should NOT update a user' do
        expect(flash[:alert]).to eq('No se pudo actualizar el usuario.')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.redirect_url).to eq(nil)
      end
    end

    describe 'DELETE /destroy' do
      before { delete(user_url(@administrador_user)) }

      it 'should destroy a user' do
        expect(flash[:notice]).to eq('Usuario eliminado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'DELETE /destroy with another user with CLIENTE role' do
      before { delete(user_url(cliente_user)) }

      it 'should destroy a user' do
        expect(flash[:notice]).to eq('Usuario eliminado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'DELETE /destroy with another user with PERSONAL BANCARIO role' do
      before { delete(user_url(personal_bancario_user)) }

      it 'should destroy a user' do
        expect(flash[:notice]).to eq('Usuario eliminado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

    describe 'DELETE /destroy with another user with ADMINISTRADOR role' do
      before { delete(user_url(administrador_user)) }

      it 'should destroy a user' do
        expect(flash[:notice]).to eq('Usuario eliminado.')
        expect(response).to redirect_to(response.redirect_url)
      end
    end

  end

end