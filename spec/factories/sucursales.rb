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
  end

end