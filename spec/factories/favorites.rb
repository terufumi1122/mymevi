# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer
#  user_id    :integer
#

FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    habit_id { 1 }
  end
end
