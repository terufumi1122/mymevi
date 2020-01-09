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

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :habit
end
