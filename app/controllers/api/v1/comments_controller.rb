class Api::V1::CommentsController < ApplicationController
  def index
    comments = Comment.select("
        id,
        content,
        user_id,
        habit_id
      ")
    render json: comments
  end

  def show
    comments = Comment.where(habit_id: params[:id]).select("
        id,
        content,
        user_id,
        habit_id
      ")
    render json: comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save!
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.permit(:id, :content, :user_id, :habit_id)
  end
end
