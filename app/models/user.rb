# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  age             :integer
#  email           :string(255)
#  gender          :integer
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
