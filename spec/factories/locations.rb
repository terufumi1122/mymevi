FactoryBot.define do
  factory :location do
    name                { Faker::String.random(length: 1..50) }
    lat                 { Faker::Address.latitude }
    lng                 { Faker::Address.longitude }
    sequence(:user_id)  { |n| n }
    sequence(:habit_id) { |n| n }

    association :user
  end
end
