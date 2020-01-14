class Api::V1::FavoritesController < ApiController
  before_action :set_current_user, only: [:current_user_index]

  def index
    favorites = Favorite.select("
      id,
      user_id,
      habit_id
      ")
    render json: favorites
  end

  def current_user_index
    favorites = Favorite.where(user_id: @current_user.id).select("
      id,
      user_id,
      habit_id
      ")
    render json: favorites
  end

  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      render json: favorite, status: :created
    else
      render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    favorite = Favorite.find_by(favorite_params)
    if favorite.destroy
      new_favorites = Favorite.select("
        id,
        user_id,
        habit_id
        ")
      render json: new_favorites
    else
      render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private

  def set_current_user
    @current_user = User.find(params[:id])
  end

  def favorite_params
    params.permit(:user_id, :habit_id)
  end
end
