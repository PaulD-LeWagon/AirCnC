class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_name, :string
    add_column :users, :image_url, :text
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :town_or_city, :string
    add_column :users, :county, :string
    add_column :users, :postcode, :string
    add_column :users, :phone_number, :string
    add_column :users, :mobile_number, :string
  end
end
