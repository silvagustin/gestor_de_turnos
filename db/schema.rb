# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_04_131645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "horarios", force: :cascade do |t|
    t.bigint "sucursal_id", null: false
    t.integer "dia", default: 0, null: false
    t.integer "hora_inicial", default: 9, null: false
    t.integer "hora_final", default: 15, null: false
    t.boolean "habilitado", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sucursal_id"], name: "index_horarios_on_sucursal_id"
  end

  create_table "sucursales", force: :cascade do |t|
    t.string "nombre", default: "", null: false
    t.string "direccion", default: "", null: false
    t.string "telefono", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_sucursales_on_nombre", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rol", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
