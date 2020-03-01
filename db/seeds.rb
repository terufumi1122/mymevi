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
puts "create admin"

User.find_or_create_by!(email: 'guest@sample.com') do |user|
  user.name = 'ゲストユーザー'
  user.email = 'guest@sample.com'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.birth_year = 1995
  user.gender = 1
end
puts "create guest user"

20.times do |n|
  User.find_or_create_by!(id: n + 2) do |user|
    user.name = Faker::Japanese::Name.first_name
    user.email = Faker::Internet.free_email
    user.password = 'password'
    user.password_confirmation = 'password'
    user.birth_year = rand(1930..2010)
    user.gender = rand(1..4)
  end
end
puts "create 20 random users"

Habit.find_or_create_by!(id: 1) do |habit|
  habit.name = '毎朝4kmラン'
  habit.description = '朝走るだけで一日が充実する気がします。非常に気持いいですし、気軽に始められるのでどなたにもオススメです。'
  habit.merit = '頭スッキリ！気分爽快です！'
  habit.best = 1
  habit.user_id = 2
  habit.location_id = 1
end
puts "create habit running"

Habit.find_or_create_by!(id: 2) do |habit|
  habit.name = '15時のコーヒー'
  habit.description = 'コーヒーは一日２杯。特に午後のコーヒーを飲まないと後半ダレますね。'
  habit.merit = '仕事の集中力が保てます'
  habit.best = 2
  habit.user_id = 2
  habit.location_id = 1
end
puts "create habit coffee"

Habit.find_or_create_by!(id: 3) do |habit|
  habit.name = '寝る前のホットミルク'
  habit.description = '寝る前に軽くストレッチして、温かいミルクを飲んで寝れば朝までほとんど熟睡できます。'
  habit.merit = '爆睡！爪がよく伸びるようになった気がします'
  habit.best = 3
  habit.user_id = 2
  habit.location_id = 1
end
puts "create habit hotmilk"

Habit.find_or_create_by!(id: 4) do |habit|
  habit.name = '図書館で勉強'
  habit.description = '都立中央図書館は電源付きの広い個別スペースもあって使いやすいです。'
  habit.merit = 'これから試すのでまだ効果は実感できていません'
  habit.best = 4
  habit.user_id = 2
  habit.location_id = 1
end
puts "create habit 4"

Habit.find_or_create_by!(id: 5) do |habit|
  habit.name = '週末のピザ'
  habit.description = '普段は健康的な食生活ですが、土日だけドカ食いします。マルゲリータ派です。'
  habit.merit = 'チートデイで平日頑張れる！'
  habit.best = 1
  habit.user_id = 3
  habit.location_id = 1
end
puts "create habit 5"

Habit.find_or_create_by!(id: 6) do |habit|
  habit.name = '平日は鶏むね肉を食べる'
  habit.description = '週末のピザを楽しみに頑張ります。塩麹に漬けると柔らかくてイケる！'
  habit.merit = '筋肉に適切な栄養を与えます。'
  habit.best = 2
  habit.user_id = 3
  habit.location_id = 1
end
puts "create habit 6"

Habit.find_or_create_by!(id: 7) do |habit|
  habit.name = '公園の散歩'
  habit.description = '近所の公園を散歩しています。都会にいても結構森林浴効果あり。'
  habit.merit = 'ふとしたアイデアが生まれます'
  habit.best = 3
  habit.user_id = 3
  habit.location_id = 1
end
puts "create habit 7"

Habit.find_or_create_by!(id: 8) do |habit|
  habit.name = '勉強中のジャズ'
  habit.description = 'ピアノだけとか、歌詞なしが集中できて良いです^^'
  habit.merit = '集中力UP!'
  habit.best = 1
  habit.user_id = 4
  habit.location_id = 1
end
puts "create habit 8"

Habit.find_or_create_by!(id: 9) do |habit|
  habit.name = '運動中のヘビメタ'
  habit.description = '重量挙げたいときにはコレ！！！'
  habit.merit = '負けない心が手に入ります。笑'
  habit.best = 2
  habit.user_id = 4
  habit.location_id = 1
end
puts "create habit 9"

Habit.find_or_create_by!(id: 10) do |habit|
  habit.name = '愛猫と戯れる'
  habit.description = '名前は「あめ」です。'
  habit.merit = 'かわいすぎ♡'
  habit.best = 3
  habit.user_id = 4
  habit.location_id = 1
end
puts "create habit 10"

Habit.find_or_create_by!(id: 11) do |habit|
  habit.name = '犬の散歩'
  habit.description = 'うちのハチ公の散歩。まだ1歳になってないから散歩いかないと暴れます。笑'
  habit.merit = '犬って自由でいいなって思います'
  habit.best = 1
  habit.user_id = 5
  habit.location_id = 1
end
puts "create habit 11"

Habit.find_or_create_by!(id: 12) do |habit|
  habit.name = 'ウイスキーで晩酌'
  habit.description = 'ジャックダニエル派です。'
  habit.merit = '寝付きが良くなる'
  habit.best = 1
  habit.user_id = 6
  habit.location_id = 1
end
puts "create habit 12"

Habit.find_or_create_by!(id: 13) do |habit|
  habit.name = 'カフェで勉強'
  habit.description = '家では集中できないので、近所の朝7時からやってるカフェで朝活してます'
  habit.merit = '朝は人も少なくていいです'
  habit.best = 1
  habit.user_id = 7
  habit.location_id = 1
end
puts "create habit 13"

Habit.find_or_create_by!(id: 14) do |habit|
  habit.name = '寝る前の読書(iPad)'
  habit.description = '寝る前にkindle本読んでます。Night shiftはマスト'
  habit.merit = '小難しい本は寝付き最高！'
  habit.best = 2
  habit.user_id = 7
  habit.location_id = 1
end
puts "create habit 14"

Habit.find_or_create_by!(id: 15) do |habit|
  habit.name = '月1回リーダブルコードを読む'
  habit.description = '見る度に「俺のはアンリーダブルコードだ...」と思わされます。'
  habit.merit = '見やすいコード書けるようになる（？）'
  habit.best = 1
  habit.user_id = 8
  habit.location_id = 1
end
puts "create habit 15"

Habit.find_or_create_by!(id: 16) do |habit|
  habit.name = '観葉植物の水やり'
  habit.description = 'がじゅまるを机に置いてます。ちょっとずつ成長していてかわいい。'
  habit.merit = '成長をみて時間の流れを感じます'
  habit.best = 2
  habit.user_id = 8
  habit.location_id = 1
end
puts "create habit 16"

Habit.find_or_create_by!(id: 17) do |habit|
  habit.name = '週1回のひとりカラオケ'
  habit.description = '木曜仕事帰り。ジャンカラ派です。そういえば、同じマークのうたひろってなんですか？'
  habit.merit = 'ストレス発散！'
  habit.best = 1
  habit.user_id = 9
  habit.location_id = 1
end
puts "create habit 17"

Habit.find_or_create_by!(id: 18) do |habit|
  habit.name = '月1回の登山'
  habit.description = '第1金曜仕事帰りに登山口に直行します。ビバ自然！'
  habit.merit = 'リセット！'
  habit.best = 1
  habit.user_id = 10
  habit.location_id = 1
end
puts "create habit 18"

Habit.find_or_create_by!(id: 19) do |habit|
  habit.name = '毎日体重計に乗る'
  habit.description = '食前に乗ってるのはヒミツです。'
  habit.merit = '現実を直視できます'
  habit.best = 2
  habit.user_id = 12
  habit.location_id = 1
end
puts "create habit 19"

Habit.find_or_create_by!(id: 20) do |habit|
  habit.name = 'DIYという名の日曜大工'
  habit.description = '木材の表面をヤスリがけしてるときが至福のひとときです。 作りすぎて部屋が圧迫されてきたのをどうしようかなあ。'
  habit.merit = '純粋に楽しい！'
  habit.best = 1
  habit.user_id = 12
  habit.location_id = 1
end
puts "create habit 20"

Location.find_or_create_by!(id: 1) do |location|
  location.name = '名もなき場所'
  location.lat = 35.65823
  location.lng = 139.701642
  location.user_id = 2
  location.habit_id = 1
end
puts "create default location"


50.times do |n|
  user_id = rand(1..21)
  habit_id = rand(1..20)
  Favorite.find_or_create_by!(user_id: user_id, habit_id: habit_id)
end
puts "create 50 random favorite"