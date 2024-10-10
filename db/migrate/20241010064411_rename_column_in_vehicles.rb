class RenameColumnInVehicles < ActiveRecord::Migration[7.1]
  def change
    rename_column :vehicles, :year_of_manufacture, :year
  end
end
