class AddCollumToRentals < ActiveRecord::Migration[7.1]
  def change
    add_reference :rentals, :vehicle, null: false, foreign_key: true
  end
end
