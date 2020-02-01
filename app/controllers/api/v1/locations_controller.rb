class Api::V1::LocationsController < ApplicationController

  def index
    locations = Location.select("
      id,
      name,
      lat,
      lng,
      user_id,
      habit_id
    ")
    render json: locations
  end

  def create
    location = Location.new(location_params)
    if location.save!
      render json: location, status: :created
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    location = Location.find(params[:id])
    if location.update!(location_params)
      new_locations = Location.select("
        id,
        name,
        lat,
        lng,
        user_id,
        habit_id
        ")
      render json: new_locations
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    location = Location.find_by(location_params)
    if location.destroy
      new_locations = Location.select("
        id,
        name,
        lat,
        lng,
        user_id,
        habit_id
        ")
      render json: new_locations
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private

  def location_params
    params.permit(:name, :lat, :lng, :user_id, :habit_id)
  end
end
