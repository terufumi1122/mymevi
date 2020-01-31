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

require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      name: "サンプルユーザー",
      email: "sample@sample.com",
      gender: 1,
      birth_year: 2000,
      birth_month: 2,
      birth_day: 20,
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    User.create(
      name: "サンプルユーザー",
      email: "sample@sample.com",
      gender: 1,
      birth_year: 2000,
      birth_month: 2,
      birth_day: 20,
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      name: "サンプルユーザー",
      email: "sample@sample.com",
      gender: 1,
      birth_year: 2000,
      birth_month: 2,
      birth_day: 20,
      password: "password",
      password_confirmation: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
