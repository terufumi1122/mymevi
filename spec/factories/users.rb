# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  birth_day              :integer          not null
#  birth_month            :integer          not null
#  birth_year             :integer          not null
#  current_sign_in_at     :datetime
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      default(""), not null
#  gender                 :integer          not null
#  image                  :string(255)
#  last_sign_in_at        :datetime
#  name                   :string(255)      not null
#  nickname               :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    gender { rand(1..4) }
    birth_year { rand(1930..2010) }
    birth_month { rand(1..13) }
    birth_day { rand(1..29) }
    password { "password" }
    password_confirmation { "password" }
  end
end
