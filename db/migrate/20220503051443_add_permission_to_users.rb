class AddPermissionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :permissions, :string, array: true, default: []
  end
end
