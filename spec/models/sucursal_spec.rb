require 'rails_helper'

RSpec.describe Sucursal, type: :model do
  context 'validations' do
    let!(:sucursal_1) { create(:sucursal) }
    let(:sucursal_2)  { build(:sucursal) }
    let(:sucursal_3)  { build(:sucursal, nombre: sucursal_1.nombre) }

    describe 'nombre uniqueness' do
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
    let(:turno)    { create(:turno) }
    let(:sucursal) { turno.sucursal }

    describe 'puede_eliminarse?' do
      it 'should be valid when there are no turnos pendientes' do
        personal_bancario = create(:user, :personal_bancario, sucursal_id: sucursal.id)
        turno.update(respuesta: Faker::Lorem.sentence, personal_bancario_id: personal_bancario.id, estado: :atendido)

        expect(sucursal.destroy).to be_valid
      end

      it 'should NOT be valid when there are turnos pendientes' do
        expect(sucursal.destroy).to eq(false)
        expect(sucursal.errors.full_messages).to include('No se puede eliminar la sucursal porque tiene turnos pendientes')
      end
    end

  end

end
