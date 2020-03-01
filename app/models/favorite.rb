class Favorite < ApplicationRecord
  with_options presence: true do
    validates :habit_id
    validates :user_id
  end
  validates :user_id, uniqueness: { scope: :habit_id }

  belongs_to :user
  belongs_to :habit
end
