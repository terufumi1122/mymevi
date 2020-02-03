# == Schema Information
#
# Table name: habits
#
#  id          :bigint           not null, primary key
#  best        :integer          not null
#  description :text(65535)      not null
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  user_id     :integer          not null
#

FactoryBot.define do
  factory :habit do
    sequence(:name) { |n| "Habit#{n}" }
    sequence(:description) { |n| "Habit#{n}'s describe" }
    best { rand(1..4) }
    user_id { 1 }

    association :user

  end
end
