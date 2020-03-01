FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8, max_length: 16)

    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    gender                { rand(1..4) }
    birth_year            { rand(1930..2010) }
    birth_month           { rand(1..13) }
    birth_day             { rand(1..29) }
    password              { password }
    password_confirmation { password }
  end
end
