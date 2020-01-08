class Api::V1::UsersController < ApiController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :set_user, only: [:show, :update, :destroy]

  # rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    users = User.select(:id, :name, :email, :birthday, :gender)
    render json: users
  end

  def show
    render json: @user
  end

  def all_users
    all_users = User.select(:id, :name, :birthday, :gender)
    render json: all_users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update_attributes(user_params)
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :birthday, :gender, :password, :password_confirmation)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
