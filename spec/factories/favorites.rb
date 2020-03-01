FactoryBot.define do
  factory :favorite do
    association :habit
    association :user
  end
end
