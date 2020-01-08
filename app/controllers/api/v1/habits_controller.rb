class Api::V1::HabitsController < ApiController
  before_action :set_current_user_habits, only: [:users_habits_show]

  def all_habits_show
    all_habits = Habit.joins(:user)
    .select("
      habits.id,
      habits.name,
      description,
      best,
      user_id,
      users.name AS user_name,
      users.birthday AS user_birthday,
      users.gender AS user_gender
      ")
    render json: all_habits
  end

  def users_habits_show
    render json: @current_user_habits
  end

  def create
    habit = Habit.new(habit_params)
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
