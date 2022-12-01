require 'rails_helper'

RSpec.describe Sucursal, type: :model do
  context 'validations' do
    describe 'nombre uniqueness' do
      let(:sucursal_1) { create(:sucursal) }
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

end
