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

ActiveRecord::Schema[8.0].define(version: 2025_09_04_170059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.bigint "park_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "category"
    t.date "last_indexed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "national_parks_internal_id"
    t.jsonb "properties", default: {}, null: false
    t.index ["park_id"], name: "index_alerts_on_park_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "states", default: [], array: true
    t.jsonb "properties", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "national_parks_internal_id"
    t.text "description"
    t.index ["code"], name: "index_parks_on_code", unique: true
  end

  add_foreign_key "alerts", "parks"
end
