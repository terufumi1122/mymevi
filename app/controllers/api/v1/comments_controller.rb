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
  end

  def update
  end

  def destroy
  end
end
