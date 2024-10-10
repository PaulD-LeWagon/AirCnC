class RemoveColumnsFromVehicle < ActiveRecord::Migration[7.1]
  def change
    remove_column :vehicles, :mot_certificate, :string
    remove_column :vehicles, :tax_details, :string
    remove_column :vehicles, :number_plate, :string
  end
end
