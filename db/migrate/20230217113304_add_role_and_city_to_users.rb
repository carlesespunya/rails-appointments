class AddRoleAndCityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, default: "Patient"
    add_column :users, :city, :string, default: ""
  end
end
