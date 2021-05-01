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

ActiveRecord::Schema.define(version: 2021_05_01_145414) do

  create_table "kills", force: :cascade do |t|
    t.datetime "killed_at"
    t.integer "match_id", null: false
    t.integer "killer_id"
    t.integer "killed_id", null: false
    t.integer "weapon_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["killed_id"], name: "index_kills_on_killed_id"
    t.index ["killer_id"], name: "index_kills_on_killer_id"
    t.index ["match_id"], name: "index_kills_on_match_id"
    t.index ["weapon_id"], name: "index_kills_on_weapon_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "code"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_matches_on_code", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_players_on_name", unique: true
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_weapons_on_name", unique: true
  end

  add_foreign_key "kills", "matches"
  add_foreign_key "kills", "players", column: "killed_id"
  add_foreign_key "kills", "players", column: "killer_id"
  add_foreign_key "kills", "weapons"
end
