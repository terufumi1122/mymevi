class Api::V1::UsersController < ApiController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :set_user, only: [:show]
  include Base64Module # Base64にエンコードした画像をデコードするメソッド集

  # rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def show
    eyecatch = @user.eyecatch
    if eyecatch.present?
      @user['image'] = encode_base64(eyecatch)
    end
    render json: @user
  end

  def all_users
    all_users = User.select(:id, :name, :birth_year, :gender)
    render json: all_users
  end
  
  def attach
    user = User.find(params[:id])
    
    if params[:avatar] 
      parse_base64(user.eyecatch, params[:avatar])
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def dettach
    user = User.find(params[:id])
    user.eyecatch.purge
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:id, :name, :email, :birth_year, :gender, :password, :password_confirmation, :avatar)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: :not_found
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: :internal_server_error
  end
end
