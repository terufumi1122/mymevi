class Api::V1::HabitsController < ApiController
  before_action :set_current_user_habits, only: [:users_habits_show]

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
