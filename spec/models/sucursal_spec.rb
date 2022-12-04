require 'rails_helper'

# TODOs:
# - [] Luego de revisar users_spec.rb, revisar estos:
  # - [] non-logged user
  # - [] cliente user
  # - [] personal_bancario user
  # - [] administrador user

  # PD: user_specs estan mas completos

RSpec.describe Sucursal, type: :model do
  let!(:sucursal_1) { create(:sucursal) }

  context 'validations' do
    describe 'nombre uniqueness' do
      let(:sucursal_2) { build(:sucursal) }
      let(:sucursal_3) { build(:sucursal, nombre: sucursal_1.nombre) }

      it 'should be valid' do
        expect(sucursal_2).to be_valid
      end

      it 'should NOT be valid' do
        expect(sucursal_3).not_to be_valid
      end

    end

    describe 'nombre presence' do
      let(:sucursal) { build(:sucursal) }

      it 'should be valid' do
        expect(sucursal).to be_valid
      end

      it 'should NOT be valid' do
        sucursal.nombre = nil
        expect(sucursal).not_to be_valid

        sucursal.nombre = ''
        expect(sucursal).not_to be_valid
      end
    end

    describe 'direccion presence' do
      let(:sucursal) { build(:sucursal) }

      it 'should be valid' do
        expect(sucursal).to be_valid
      end

      it 'should NOT be valid' do
        sucursal.direccion = nil
        expect(sucursal).not_to be_valid

        sucursal.direccion = ''
        expect(sucursal).not_to be_valid
      end
    end

    describe 'telefono presence' do
      let(:sucursal) { build(:sucursal) }

      it 'should be valid' do
        expect(sucursal).to be_valid
      end

      it 'should NOT be valid' do
        sucursal.telefono = nil
        expect(sucursal).not_to be_valid

        sucursal.telefono = ''
        expect(sucursal).not_to be_valid
      end
    end

  end

  context 'callbacks' do
    describe '#after_create' do
      it 'should have horarios' do
        expect(sucursal_1.horarios).not_to be_empty
      end

    end

  end

end
