class RenameColumnAndChangeTypeToTextInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :address_1, :address
    change_column :users, :address, :text
  end
end
