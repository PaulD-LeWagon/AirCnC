class VehiclesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
      @vehicles = Vehicle.all
  end

    def new
      @vehicle = Vehicle.new
    end

    def create
      @vehicle = Vehicle.new(vehicle_params)
      if @vehicle.save
        redirect_to @vehicle, notice: 'Your vehicle was successfully created.'
      else
        render :new
      end
    end

    private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year_of_manufacture, :description, :mot_certificate, :tax_details, :number_plate, :price_per_day, :colour, :location_of_vehicle, :image_url)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    # @desc = JSON.parse(@vehicle.description)
  end
end
