# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180324215108) do

  create_table "actuators", force: :cascade do |t|
    t.string "name"
    t.string "write_key"
    t.integer "output", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["write_key"], name: "index_actuators_on_write_key", unique: true
  end

  create_table "control_loops", force: :cascade do |t|
    t.string "name"
    t.integer "mode"
    t.decimal "reference", precision: 6, scale: 3
    t.string "parameters"
    t.integer "sensor_id"
    t.integer "actuator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actuator_id"], name: "index_control_loops_on_actuator_id"
    t.index ["sensor_id"], name: "index_control_loops_on_sensor_id"
  end

  create_table "data", force: :cascade do |t|
    t.integer "sensor_id"
    t.string "value"
    t.datetime "measured_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name"
    t.string "write_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["write_key"], name: "index_sensors_on_write_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
