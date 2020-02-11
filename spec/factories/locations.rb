# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  lat        :float(53)        not null
#  lng        :float(53)        not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_locations_on_lat_and_lng  (lat,lng) UNIQUE
#

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
