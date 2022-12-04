class CrearHorarios < ActiveRecord::Migration[7.0]
  def change
    create_table :horarios do |t|
      t.belongs_to :sucursal,  null: false

      t.integer :dia,          null: false, default: 0
      t.integer :hora_inicial, null: false, default: 9
      t.integer :hora_final,   null: false, default: 15
      t.boolean :habilitado,   null: false, default: false

      t.timestamps             null: false
    end
  end
end
