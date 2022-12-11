require 'rails_helper'

RSpec.describe Horario, type: :model do
  context 'associations' do
    let(:horario) { build(:horario) }

    describe 'sucursal' do
      it 'should be valid' do
        expect(horario.sucursal).not_to eq(nil)
      end

      it 'should NOT be valid' do
        horario.sucursal = nil

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(sucursal: ['must exist'])
      end
    end

  end

  context 'validations' do
    let(:horario) { build(:horario) }

    describe 'habilitado inclusion' do
      it 'should be valid' do
        expect(horario).to be_valid
      end

      it 'should NOT be valid' do
        horario = build(:horario, habilitado: nil)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(habilitado: ['is not included in the list'])
      end
    end

    describe 'hora_inicial, hora_final numericality' do
      it 'should be valid' do
        expect(horario).to be_valid
      end

      it 'should NOT be valid when using types not allowed' do
        horario = build(:horario, hora_inicial: nil, hora_final: 'qwerty')

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ['is not a number'], hora_final: ['is not a number'])
      end

      it 'should NOT be valid when not reaching the minimum value allowed' do
        horario = build(:horario, hora_inicial: 0, hora_final: 0)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ["must be greater than or equal to 9", "'hora_inicial' debe ser MENOR a 'hora_final'"], hora_final: ['must be greater than or equal to 9'])
      end

      it 'should NOT be valid when exceeding limit allowed' do
        horario = build(:horario, hora_inicial: 9999, hora_final: 9999)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ["must be less than or equal to 15", "'hora_inicial' debe ser MENOR a 'hora_final'"], hora_final: ['must be less than or equal to 15'])
      end

      it 'should NOT be valid when values are not integer' do
        horario = build(:horario, hora_inicial: 9.5, hora_final: 12.5)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ['must be an integer'], hora_final: ['must be an integer'])
      end
    end

    describe 'hora_inicial_es_menor_que_hora_final' do
      it 'should NOT be valid when both are the same' do
        horario = build(:horario, hora_inicial: 9, hora_final: 9)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ["'hora_inicial' debe ser MENOR a 'hora_final'"])
      end

      it 'should NOT be valid when hora_final > hora_inicial' do
        horario = build(:horario, hora_inicial: 15, hora_final: 9)

        expect(horario).not_to be_valid
        expect(horario.errors.messages).to include(hora_inicial: ["'hora_inicial' debe ser MENOR a 'hora_final'"])
      end
    end

    describe 'inclusion' do
      let(:horario) { build(:horario) }

      it 'should be valid' do
        expect(horario).to be_valid
      end

      it 'should NOT be valid' do
        horario_1 = build(:horario, habilitado: nil)
        horario_2 = build(:horario, habilitado: '')

        expect(horario_1).not_to be_valid
        expect(horario_2).not_to be_valid
      end
    end

  end

  context 'scopes' do
    describe 'habilitados' do
      it 'should NOT return horarios not habilitados' do
        horario = create(:horario, habilitado: false)
        expect(Horario.habilitados).not_to include(horario)
      end
    end

  end

  context 'class methods' do
    let!(:sucursal) { create(:sucursal) }

    describe '#self.crear_horarios(sucursal_id:)' do
      it 'should create horarios' do
        expect(sucursal.horarios).to be_empty
        Horario.crear_horarios(sucursal_id: sucursal.id)
        expect(sucursal.horarios).not_to be_empty
      end

      it 'should NOT create horarios' do
        sucursal_id_1 = nil
        sucursal_id_2 = 'qwerty'

        expect(Horario.crear_horarios(sucursal_id: sucursal_id_1)).to eq("'sucursal_id' debe ser un numero entero")
        expect(Horario.crear_horarios(sucursal_id: sucursal_id_2)).to eq("'sucursal_id' debe ser un numero entero")
      end
    end

  end

end
