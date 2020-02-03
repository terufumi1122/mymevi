# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by!(email: 'admin@sample.com') do |user|
  user.name = 'admin'
  user.email = 'admin@sample.com'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.birth_year = 2000
  user.birth_month = 10
  user.birth_day = 10
  user.gender = 2
end

User.find_or_create_by!(email: 'guest@sample.com') do |user|
  user.name = 'ゲストユーザー'
  user.email = 'guest@sample.com'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.birth_year = 1995
  user.birth_month = 1
  user.birth_day = 1
  user.gender = 1
end

Habit.find_or_create_by!(id: 1) do |habit|
  habit.name = 'サンプル'
  habit.description = 'サンプル(詳細)'
  habit.best = 1
  habit.user_id = 37
  habit.location_id = 1
end

Location.find_or_create_by!(id: 1) do |location|
  location.name = '名もなき場所'
  location.lat = 35.65823
  location.lng = 139.701642
  location.user_id = 37
  location.habit_id = 30
end
