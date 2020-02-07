# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_favorites_on_user_id_and_habit_id  (user_id,habit_id) UNIQUE
#

class Favorite < ApplicationRecord
  with_options presence: true do
    validates :habit_id
    validates :user_id
  end
  validates :user_id, uniqueness: { scope: :habit_id }

  belongs_to :user
  belongs_to :habit
end
