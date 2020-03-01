FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    habit { nil }
  end
end
