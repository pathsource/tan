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

ActiveRecord::Schema.define(version: 20151024234751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "lat"
    t.decimal  "lon"
    t.string   "image",            default: "--- []\n"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "address"
    t.string   "background"
    t.string   "sponsor"
    t.text     "detail"
    t.string   "location"
    t.string   "unit_type"
    t.integer  "unit_steps_count"
  end

  add_index "projects", ["image"], name: "index_projects_on_image", using: :btree

  create_table "puzzles", force: :cascade do |t|
    t.string   "content"
    t.string   "answer"
    t.integer  "project_id"
    t.string   "hint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
