class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :make
      t.string :model
      t.integer :year_of_manufacture
      t.text :description
      t.text :mot_certificate
      t.text :tax_details
      t.string :number_plate
      t.decimal :price_per_day
      t.string :colour
      t.string :location_of_vehicle
      t.text :image_url

      t.timestamps
    end
  end
end
