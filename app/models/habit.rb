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
