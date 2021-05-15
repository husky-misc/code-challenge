# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_15_192106) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "logs", force: :cascade do |t|
    t.string "game_mode", null: false
    t.string "description"
    t.boolean "is_valid", default: false, null: false
    t.boolean "team_mode", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "ranking_id", null: false
    t.integer "frags", default: 0, null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.json "content", null: false
    t.string "strike_player"
    t.string "winner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"match_id\", \"name\"", name: "unique_name_by_match", unique: true
    t.index ["ranking_id"], name: "index_matches_on_ranking_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "match_id", null: false
    t.string "name", null: false
    t.integer "frags"
    t.integer "deads"
    t.boolean "awarded", default: false, null: false
    t.string "strong_weapon"
    t.boolean "strong_killer"
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_players_on_match_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "log_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "processed_at"
    t.datetime "rejected_at"
    t.index ["log_id"], name: "index_rankings_on_log_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "matches", "rankings"
  add_foreign_key "players", "matches"
  add_foreign_key "rankings", "logs"
end
