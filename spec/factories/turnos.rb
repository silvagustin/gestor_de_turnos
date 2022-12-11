FactoryBot.define do
  factory :turno do
    cliente  { create(:user) }
    sucursal { FactoryBot.create(:sucursal, :con_horarios_habilitados) }

    motivo   { Faker::Lorem.sentence }
    horario  { Time.new(2112, 12, 12, 10) }

    trait :atendido do
      after(:create) do |turno|
        personal_bancario = create(:user, :personal_bancario)
        turno.update(personal_bancario_id: personal_bancario.id, respuesta: Faker::Lorem.sentence)
      end
    end

  end

end