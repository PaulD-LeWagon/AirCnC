class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.date :hire_start_date
      t.date :hire_end_date
      t.string :duration
      t.decimal :charge

      t.timestamps
    end
  end
end
