class AddSucursalToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference(:users, :sucursal, index: true)
  end
end
