FactoryBot.define do
  factory :habit do
    name               { Faker::Lorem.sentence }
    description        { Faker::Lorem.paragraph }
    merit              { Faker::Lorem.sentence }
    best               { rand(1..4) }
    sequence(:user_id) { |n| n }

    association :user
  end
end
