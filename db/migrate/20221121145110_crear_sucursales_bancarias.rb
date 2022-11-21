class CrearSucursalesBancarias < ActiveRecord::Migration[7.0]
  def change
    create_table :sucursales_bancarias do |t|
      t.string :nombre,    null: false, default: ""
      t.string :direccion, null: false, default: ""
      t.string :telefono,  null: false, default: ""

      t.timestamps         null: false
    end

    add_index :sucursales_bancarias, :nombre, unique: true
  end
end
