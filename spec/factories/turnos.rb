FactoryBot.define do
  factory :turno do
    cliente  { create(:user) }
    sucursal { FactoryBot.create(:sucursal, :con_horarios_habilitados) }

    motivo   { Faker::Lorem.sentence }
    horario  { Time.new(2112, 12, 12, 10) }
  end
end