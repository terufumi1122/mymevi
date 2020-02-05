class Api::V1::HabitsController < ApplicationController
  include Base64Module #Base64にエンコードした画像をデコードするメソッド集


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
    # current_user_habits = Habit.where(user_id: params[:user_id]).joins(:user)
    current_user_habits = Habit.order('best ASC').where(user_id: params[:user_id]).joins(:user)
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

    if eyecatch.present?
      puts habit
      habit['image'] = encode_base64(eyecatch) #renderするデータに画像データを追加する
    end

    render json: habit
  end

  def create
    habit = Habit.new(habit_params)

    if habit.save!
      if habit_params[:image]
        parse_base64(habit.eyecatch, habit_params[:image]) #画像を添付する
      end
      render json: habit, status: :created
    else
      render json: { errors: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    habit = Habit.find(habit_params[:id])

    if habit_params[:image]
      parse_base64(habit.eyecatch, habit_params[:image]) #画像を添付する
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
