class Api::V1::HabitsController < ApiController

  def all_habits_show
    all_habits = Habit.joins(:user)
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
      user_id,
      users.name AS user_name,
      users.gender AS user_gender
    ")
    render json: habit_detail
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

  def habit_params
    params.permit(:name, :description, :best, :user_id)
  end
end
