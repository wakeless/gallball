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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120427074128) do

  create_table "games", :force => true do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sport_id"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ranks", :force => true do |t|
    t.integer  "player_id"
    t.integer  "sport_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "game_id"
  end

  add_index "ranks", ["player_id"], :name => "index_ranks_on_player_id"
  add_index "ranks", ["sport_id"], :name => "index_ranks_on_sport_id"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
