FactoryBot.define do
  factory :sucursal do
    nombre    { Faker::Company.name }
    direccion { Faker::Address.full_address }
    telefono  { Faker::PhoneNumber.phone_number }

    trait :con_horarios do
      after(:create) do |sucursal|
        Horario.crear_horarios(sucursal_id: sucursal.id)
      end
    end

    trait :con_horarios_habilitados do
      after(:create) do |sucursal|
        Horario.crear_horarios(sucursal_id: sucursal.id)
        sucursal.horarios.update_all(habilitado: true)
      end
    end

  end

end