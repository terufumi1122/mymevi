# == Schema Information
#
# Table name: habits
#
#  id          :bigint           not null, primary key
#  best        :integer          not null
#  description :text(65535)      not null
#  merit       :string(191)      not null
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  user_id     :integer          not null
#

class Habit < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :merit
    validates :best
    validates :user_id
  end

  belongs_to       :user
  has_many         :favorites, dependent: :destroy
  has_many         :comments, dependent: :destroy
  has_one_attached :eyecatch

  attr_accessor    :image
end
