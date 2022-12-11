require 'rails_helper'

RSpec.describe User, type: :model do
  context 'callbacks' do
    let!(:cliente_user)      { create(:user) }
    let!(:personal_bancario) { create(:user, :personal_bancario) }
    let!(:administrador)     { create(:user, :administrador) }

    describe 'before_save - nullify sucursal if user rol is not personal_bancario' do
      it 'should nullify sucursal_id' do
        personal_bancario.update(rol: :cliente)
        expect(personal_bancario.sucursal_id).to be_nil
      end

      it 'should NOT nullify sucursal_id' do
        personal_bancario.touch
        expect(personal_bancario.sucursal_id).to be_truthy
      end
    end

  end

  context 'scopes' do
    let!(:cliente_user)      { create(:user) }
    let!(:personal_bancario) { create(:user, :personal_bancario) }
    let!(:administrador)     { create(:user, :administrador) }

    describe 'clientes' do
      it 'should only return users with rol cliente' do
        expect(User.clientes).to     include(cliente_user)
        expect(User.clientes).not_to include(personal_bancario, administrador)
      end
    end

  end

end
