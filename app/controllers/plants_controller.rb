class PlantsController < ApplicationController

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  rescue ActiveRecord::NoRecordFound
    not_found_error_res
  end

  def destroy
    plant = find_plant
    plant.destroy
  rescue ActiveRecord::NoRecordFound
    not_found_error_res
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find_by(id: params[:id])
  end

  def not_found_error_res
    render json: {error: "Plant not found"}, status: :not_found
  end
end
