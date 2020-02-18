# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_habit_id  (habit_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (habit_id => habits.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    habit { nil }
  end
end