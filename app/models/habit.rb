# == Schema Information
#
# Table name: habits
#
#  id          :bigint           not null, primary key
#  best        :integer
#  description :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Habit < ApplicationRecord
  belongs_to :user
end
