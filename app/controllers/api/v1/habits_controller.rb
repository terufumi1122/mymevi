class Api::V1::HabitsController < ApiController

  def all_habits_show
    all_habits = Habit.order('id DESC').joins(:user)
    .select("
      habits.id,
      habits.name,
      description,
      best,
      user_id,
      users.name AS user_name,
      users.birth_year AS user_birth_year,
      users.birth_month AS user_birth_month,
      users.birth_day AS user_birth_day,
      users.gender AS user_gender
      ")
    render json: all_habits
  end
    
  #生SQL版（途中）
  # def all_habits_show
  #   sql =  'SELECT
  #   habits.id,
  #   habits.name,
  #   description,
  #   best,
  #   habits.user_id AS user_id,
  #   users.name AS user_name,
  #   users.birth_year AS user_birth_year,
  #   users.birth_month AS user_birth_month,
  #   users.birth_day AS user_birth_day,
  #   users.gender AS user_gender,
  #   locations.name AS location_name
  #   FROM `habits` INNER JOIN `users` ON `users`.`id` = `habits`.`user_id` INNER JOIN `locations` ON `locations`.`id` = `habits`.`location_id` ORDER BY id DESC'
  #   all_habits = Habit.find_by_sql(sql)
  #   render json: all_habits
  # end

  def users_habits_show
    current_user_habits = Habit.where(user_id: params[:user_id]).joins(:user)
    .select("
      habits.id,
      habits.name,
      description,
      best,
      user_id,
      users.name AS user_name,
      users.birth_year AS user_birth_year,
      users.birth_month AS user_birth_month,
      users.birth_day AS user_birth_day,
      users.gender AS user_gender
      ")
    render json: current_user_habits
  end

  def habit_detail
    habit_detail = Habit.where(id: params[:habit_id]).joins(:user)
    .select("
      habits.id,
      habits.name,
      description,
      best,
      habits.user_id,
      users.name AS user_name,
      users.gender AS user_gender,
      location_id
      ")
    
    habit = habit_detail[0].as_json #アイキャッチ画像がなければここまでのデータを返す
      
    eyecatch = habit_detail[0].eyecatch
    if eyecatch.present? #アイキャッチ画像があればDBから引っ張る
      encoded_image = Base64.encode64(eyecatch.download) #アイキャッチ画像をBase64でエンコードする
      blob = ActiveStorage::Blob.find(eyecatch[:id]) #アイキャッチ画像のBlobオブジェクト
      habit_image = "data:#{blob[:content_type]};base64,#{encoded_image}" #Vue側で面倒な変換不要で読み込める形式に整形する

      habit = habit_detail[0].as_json #renderするデータに追加する
      habit['image'] = habit_image #renderするデータに画像データを追加する
    end

    render json: habit
  end

  def create
    habit = Habit.new(habit_params)
    if habit.save!
      
      #Habitモデルに画像を添付する
      if habit_params[:image].present?
        image = habit_params[:image]
        prefix = image[/(image|application)(\/.*)(?=\;)/] #prefixをBase64でエンコードした文字列の中から正規表現で抜き出す
        type = prefix.sub(/(image|application)(\/)/, '') #画像の拡張子をprefixから正規表現で抜き出す
        data = Base64.decode64(image.sub(/data:#{prefix};base64,/, '')) #Vue.js側でエンコードした文字列をデコードする
        filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{type}" #現在時刻でファイル名作成

        File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f| #tmp/ディレクトリにファイルを仮作成
          f.write(data) #デコードした画像データを作成したファイルに書き込み
        end

        habit.eyecatch.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)  #habit.eyecatchにデコードした画像データファイルを添付する
        FileUtils.rm("#{Rails.root}/tmp/#{filename}") #作業用に作成した一時ファイルを削除
      end
      
      render json: habit, status: :created
    else
      render json: { errors: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    habit = Habit.find(habit_params[:id])
    #Habitモデルに画像を添付する
    if habit_params[:image].present?
      image = habit_params[:image]
      prefix = image[/(image|application)(\/.*)(?=\;)/] #prefixをBase64でエンコードした文字列の中から正規表現で抜き出す
      type = prefix.sub(/(image|application)(\/)/, '') #画像の拡張子をprefixから正規表現で抜き出す
      data = Base64.decode64(image.sub(/data:#{prefix};base64,/, '')) #Vue.js側でエンコードした文字列をデコードする
      filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{type}" #現在時刻でファイル名作成
  
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f| #tmp/ディレクトリにファイルを仮作成
        f.write(data) #デコードした画像データを作成したファイルに書き込み
      end
  
      habit.eyecatch.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)  #habit.eyecatchにデコードした画像データファイルを添付する
      FileUtils.rm("#{Rails.root}/tmp/#{filename}") #作業用に作成した一時ファイルを削除
    end

    unless habit.update!(habit_params)
      render json: { errors: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    habit = Habit.find(params[:id])
    unless habit.destroy!
      render json: { errors: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def habit_params
    params.permit(:id, :name, :description, :best, :user_id, :location_id, :image)
  end
end
