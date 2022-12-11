require 'rails_helper'

RSpec.describe Turno, type: :model do
  context 'validations' do
    let(:turno) { build(:turno) }

    describe 'cliente, sucursal associations' do
      it 'should be valid' do
        expect(turno).to be_valid
      end

      it 'should NOT be valid' do
        turno.cliente  = nil
        turno.sucursal = nil

        expect(turno).not_to be_valid
        expect(turno.errors.messages).to include(cliente: ['must exist'], sucursal: ['must exist'])
      end
    end

    describe 'motivo presence' do
      it 'should be valid' do
        expect(turno).to be_valid
      end

      it 'should NOT be valid' do
        turno.motivo = nil
        expect(turno.save).to eq(false)

        turno.motivo = ''
        expect(turno.save).to eq(false)
      end
    end

    describe 'horario presence' do
      it 'should be valid' do
        expect(turno).to be_valid
      end

      it 'should NOT be valid' do
        turno.horario = nil
        expect(turno.save).to eq(false)

        turno.horario = ''
        expect(turno.save).to eq(false)
      end
    end

    describe 'respuesta presence' do
      let(:turno) { create(:turno) }

      it 'should NOT be valid' do
        expect(turno.update(respuesta: nil)).to eq(false)
        expect(turno.update(respuesta: '')).to eq(false)
      end
    end

    describe 'horario_valido?' do
      it 'should be valid' do
        expect(turno).to be_valid
      end

      it 'should NOT be valid when date is in the past' do
        turno.horario = Time.new(2022, 12, 5, 11, 0, 0) # 5/12 es lunes
        expect(turno.save).to be_falsey
        expect(turno.errors.messages).to include(horario: ['no puede ser una fecha del pasado'])
      end

      it 'should NOT be valid when sucursal has no horarios habilitados' do
        turno.sucursal.horarios.destroy_all
        expect(turno.save).to be_falsey
        expect(turno.errors.messages).to include(base: ['la sucursal no tiene horarios habilitados'])
      end
    end

  end

  context 'scopes' do
    describe 'pendientes' do
      let(:turno_pendiente_1) { create(:turno) }
      let(:turno_pendiente_2) { create(:turno) }
      let(:turno_atendido)    { create(:turno, :atendido) }

      it 'should only return turnos with estado pendiente' do
        expect(Turno.pendientes).to     include(turno_pendiente_1, turno_pendiente_2)
        expect(Turno.pendientes).not_to include([turno_atendido])
      end
    end

  end

end
