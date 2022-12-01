FactoryBot.define do
  factory :sucursal do
    nombre    { Faker::Company.name }
    direccion { Faker::Address.full_address }
    telefono  { Faker::PhoneNumber.phone_number }
  end

end