class Location < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :lat
    validates :lng
    validates :user_id
  end

  belongs_to :user
end
