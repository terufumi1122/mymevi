FactoryBot.define do
  factory :habit do
    sequence(:name) { |n| "Habit#{n}" }
    sequence(:description) { |n| "Habit#{n}'s describe" }
    best { rand(1..4) }
    user_id { 1 }
  end
end