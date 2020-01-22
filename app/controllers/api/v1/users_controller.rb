class Api::V1::UsersController < ApiController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :set_user, only: [:show]

  # rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def show
    render json: @user
  end

  def all_users
    all_users = User.select(:id, :name, :birth_year, :birth_month, :birth_day, :gender)
    render json: all_users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :birth_year, :birth_month, :birth_day, :gender, :password, :password_confirmation)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
