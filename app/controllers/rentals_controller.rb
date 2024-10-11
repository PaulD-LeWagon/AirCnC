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
          resp = {
            status: "Success",
            data: @rental,
            errors: "",
            message: "Booking successfully created!",
          }
          render json: resp.to_json, notice: "Your booking was successful!", status: :see_other
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          resp = {
            status: "Error",
            data: @rental,
            errors: @rental.errors,
            message: "Booking NOT created!",
          }
          render json: resp.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @vehicle = @rental.vehicle
    @rental.destroy
    redirect_to vehicles_path(@vehicle), status: :see_other
  end

  private

  # This should be irrelevent when Ajax is implemented
  def calculate_charge(rental)
    days = rental.hire_end_date == rental.hire_start_date ? 1 : (rental.hire_end_date - rental.hire_start_date).to_i
    rental.vehicle.price_per_day * days
  end
end
