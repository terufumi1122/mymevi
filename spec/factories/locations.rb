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
#  habit_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_locations_on_lat_and_lng  (lat,lng) UNIQUE
#

FactoryBot.define do
  factory :location do
    name { "MyString" }
    lat { 1.5 }
    lng { 1.5 }
    user_id { 1 }
    habit_id { 1 }
  end
end
