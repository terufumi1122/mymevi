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
  user.gender = 2
end

User.find_or_create_by!(email: 'guest@sample.com') do |user|
  user.name = 'ゲストユーザー'
  user.email = 'guest@sample.com'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.birth_year = 1995
  user.gender = 1
end

20.times do |n|
  User.find_or_crete_by!(id: n + 2) do |user|
    user.name = Faker::Japanese::Name.first_name
    user.email = Faker::Internet.free_email
    user.password = 'password'
    user.password_confirmation = 'password'
    user.birth_year = rand(1930..2010)
    user.gender = rand(1..4)
  end
end

Habit.find_or_create_by!(id: 1) do |habit|
  habit.name = '毎朝4kmラン'
  habit.description = '朝走るだけで一日が充実する気がします。非常に気持いいですし、気軽に始められるのでどなたにもオススメです。'
  habit.merit = '頭スッキリ！気分爽快です！'
  habit.best = 1
  habit.user_id = 2
  habit.location_id = 1
end

Habit.find_or_create_by!(id: 2) do |habit|
  habit.name = '15時のコーヒー'
  habit.description = 'コーヒーは一日２杯。特に午後のコーヒーを飲まないと後半ダレますね。'
  habit.merit = '仕事の集中力が保てます'
  habit.best = 2
  habit.user_id = 2
  habit.location_id = 1
end

Habit.find_or_create_by!(id: 3) do |habit|
  habit.name = '寝る前のホットミルク'
  habit.description = '寝る前に軽くストレッチして、温かいミルクを飲んで寝れば朝までほとんど熟睡できます。'
  habit.merit = '爆睡！爪がよく伸びるようになった気がします'
  habit.best = 3
  habit.user_id = 2
  habit.location_id = 1
end

Habit.find_or_create_by!(id: 4) do |habit|
  habit.name = '図書館で勉強'
  habit.description = '都立中央図書館は電源付きの広い個別スペースもあって使いやすいです。'
  habit.merit = 'これから試すのでまだ効果は実感できていません'
  habit.best = 4
  habit.user_id = 2
  habit.location_id = 1
end

Location.find_or_create_by!(id: 1) do |location|
  location.name = '名もなき場所'
  location.lat = 35.65823
  location.lng = 139.701642
  location.user_id = 2
  location.habit_id = 1
end