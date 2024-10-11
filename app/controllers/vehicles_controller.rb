class VehiclesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    if user_signed_in?
      if current_user.rentals.where(vehicle_id: params[:id]).present?
        @rental = current_user.rentals.where(vehicle_id: params[:id]).first
        # Okay got a booking hide form show cancel/delete button
        @show_cancel_button = true
      else
        # Signed in but no booking so show form
        @show_hire_form = true
        @rental = Rental.new({ vehicle: @vehicle, user: current_user })
      end
    else # Not signed in show sign in button
      @show_hire_form = false
    end
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
