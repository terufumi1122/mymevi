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