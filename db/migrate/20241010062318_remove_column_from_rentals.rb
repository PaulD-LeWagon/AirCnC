class RemoveColumnFromRentals < ActiveRecord::Migration[7.1]
  def change
    remove_column :rentals, :duration, :string
  end
end
