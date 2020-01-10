class Api::V1::FavoritesController < ApiController

  before_action :set_favorites, only: [:index]

  def index
    render json: @favorites
  end

  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      render json: favorite, status: :created
    else
      render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_favorites
    @favorites = Favorite.all
  end

  def favorite_params
    params.permit(:user_id, :habit_id)
  end
end
