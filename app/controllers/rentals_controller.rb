class RentalsController < ApplicationController
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @rental = Rental.new({
      vehicle: @vehicle,
      user: current_user,
    })
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    @rental = Rental.new(params.require(:rental).permit(:hire_start_date, :hire_end_date, :charge))
    @rental.vehicle = @vehicle
    @rental.user = current_user
    respond_to do |format|
      if @rental.save!
        format.html { redirect_to vehicle_path(@vehicle), notice: "Your booking was successful!", status: :see_other }
        format.json do
          render json: @rental.to_json, notice: "Your booking was successful!", status: :see_other
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @rental.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def calculate_charge(rental)
    days = rental.hire_end_date == rental.hire_start_date ? 1 : (rental.hire_end_date - rental.hire_start_date).to_i
    rental.vehicle.price_per_day * days
  end
end
