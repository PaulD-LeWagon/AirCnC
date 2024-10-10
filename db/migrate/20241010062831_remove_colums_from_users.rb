class RemoveColumsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :user_name, :string
    remove_column :users, :address_2, :string
    remove_column :users, :town_or_city, :string
    remove_column :users, :county, :string
    remove_column :users, :postcode, :string
    remove_column :users, :mobile_number, :string
  end
end
