# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160306201028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "damages", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "damage_amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "damages", ["game_id"], name: "index_damages_on_game_id", using: :btree
  add_index "damages", ["player_id"], name: "index_damages_on_player_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "player_1_id"
    t.integer  "player_2_id"
    t.integer  "winner_player_id"
    t.integer  "winner_remaining_health"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "games", ["player_1_id"], name: "index_games_on_player_1_id", using: :btree
  add_index "games", ["player_2_id"], name: "index_games_on_player_2_id", using: :btree
  add_index "games", ["winner_player_id"], name: "index_games_on_winner_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "damages", "games"
  add_foreign_key "damages", "players"
end
