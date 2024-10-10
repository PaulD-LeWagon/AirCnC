class ChangeLocationOfVehiclesTypeToTextAndRenameToJustLocationInVehicles < ActiveRecord::Migration[7.1]
  def change
    rename_column :vehicles, :location_of_vehicle, :location
    change_column :vehicles, :location, :text
  end
end
