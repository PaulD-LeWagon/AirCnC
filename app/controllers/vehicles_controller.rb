class VehiclesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @desc = JSON.parse(@vehicle.description)
  end
end
