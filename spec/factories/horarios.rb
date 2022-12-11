FactoryBot.define do
  factory :horario do
    hora_inicial { rand(9..12) }
    hora_final   { rand(13..15) }
    habilitado  { true }

    sucursal { create(:sucursal) }

  end

end
