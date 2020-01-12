class Api::V1::FavoritesController < ApiController

  def index
    favorites = Favorite.select("
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
    # favoritesに消したいデータを抽出し、代入する
    favorites = Favorite.find_by(favorite_params)
    # favoritesをテーブルから消す
    if favorites.destroy
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

  def favorite_params
    params.permit(:user_id, :habit_id)
  end
end
