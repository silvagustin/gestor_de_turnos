require 'rails_helper'
require 'support/session'

RSpec.describe "Sucursales", type: :request do
  context 'as a user with CLIENTE rol' do
    include_context :login_cliente_user

    describe 'GET index' do
      before { get(sucursales_url) }

      it 'should not render index page' do
        expect(response).to redirect_to(edit_user_url(@cliente_user))
      end

    end

  end

end