FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    rol                   { :cliente }
    password              { '123123123' }
    password_confirmation { password }

    trait :administrador do
      rol { :administrador }
    end

    trait :personal_bancario do
      rol { :personal_bancario }
    end

  end

end