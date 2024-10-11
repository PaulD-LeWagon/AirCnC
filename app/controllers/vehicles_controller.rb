class VehiclesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @vehicles = Vehicle.all
  end

  def show
    @hide_hire_button = current_user.rentals.where(vehicle_id: params[:id]).present?
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    user = current_user
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user = user
    if @vehicle.save
      redirect_to vehicle_path(@vehicle), notice: "Your vehicle was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year_of_manufacture, :description, :mot_certificate, :tax_details, :number_plate, :price_per_day, :colour, :location_of_vehicle, :image_url)
  end
end
