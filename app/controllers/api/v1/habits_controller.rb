class Api::V1::HabitsController < ApiController
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

  # def set_habit
  #   @habit = Habit.find(params[:id])
  # end

  def habit_params
    params.permit(:name, :description, :best, :user_id)
  end
end
