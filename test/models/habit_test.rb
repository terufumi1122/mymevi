# == Schema Information
#
# Table name: habits
#
#  id          :bigint           not null, primary key
#  best        :integer          not null
#  description :string(255)      not null
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#

require 'test_helper'

class HabitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
