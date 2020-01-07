class Api::V1::HabitsController < ApiController
  before_action :set_current_user_habits, only: [:users_habits_show]

  def all_habits_show
    # all_habits = Habit.joins(:user) #成功パターン。user_idありのものだけ取得する
    # all_habits = Habit.includes(:user) #失敗
    # all_habits = Habit.left_joins(:user) #user_idがない場合も取得する
    # all_habits = Habit.joins(:user).includes(:user)  #ベスト！
    # all_habits = Habit.joins(:user).includes(:user).where(best: 1..3) #いいね
    # all_habits = Habit.joins(:user).includes(:user)
    all_habits = Habit.joins(:user)
    .select("
      habits.id,
      habits.name,
      description,
      best,
      user_id,
      users.name AS user_name,
      users.age AS user_age,
      users.gender AS user_gender
      ")
    # .includes(:user)
    # .where(best: 1..3)
    # .select("habit.*, user.*")
    # render json: all_habits.to_json(include: :user)
    render json: all_habits
  end

  def users_habits_show
    render json: @current_user_habits
  end

  def create
    habit = Habit.new(habit_params)
    # habit.user_id = current_user.id
    if habit.save
      render json: habit, status: :created
    else
      render json: { errors: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end

    private

  def set_current_user_habits
    @current_user_habits = Habit.where(user_id: params[:user_id])
  end

  def habit_params
    params.permit(:name, :description, :best, :user_id)
  end
end
