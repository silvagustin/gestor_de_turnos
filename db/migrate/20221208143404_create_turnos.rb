class CreateTurnos < ActiveRecord::Migration[7.0]
  def change
    create_table :turnos do |t|
      t.belongs_to :cliente, foreign_key: { to_table: 'users' }, null: false
      t.belongs_to :sucursal, null: false

      t.belongs_to :personal_bancario, foreign_key: { to_table: 'users' }

      # Campos para Cliente
      t.text :motivo, null: false
      t.datetime :horario, null: false

      # Campos para Personal bancario
      t.text :respuesta
      t.integer :estado, null: false, default: 0

      t.timestamps
    end
  end
end
