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

class Location < ApplicationRecord
end
