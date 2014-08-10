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

ActiveRecord::Schema.define(version: 20140810035004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composer_night_signups", force: true do |t|
    t.integer  "person_id"
    t.integer  "composer_night_id"
    t.text     "comments"
    t.text     "title"
    t.text     "performers"
    t.text     "approx_length"
    t.text     "description"
    t.text     "special_needs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "composer_night_signups", ["composer_night_id"], name: "index_composer_night_signups_on_composer_night_id", using: :btree
  add_index "composer_night_signups", ["created_at"], name: "index_composer_night_signups_on_created_at", using: :btree
  add_index "composer_night_signups", ["person_id"], name: "index_composer_night_signups_on_person_id", using: :btree

  create_table "composer_nights", force: true do |t|
    t.datetime "start_time"
    t.integer  "location_id"
    t.integer  "slots"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "composer_nights", ["start_time"], name: "index_composer_nights_on_start_time", using: :btree

  create_table "locations", force: true do |t|
    t.text     "name"
    t.text     "url"
    t.text     "address"
    t.string   "map_image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.text     "name"
    t.text     "name_for_searching"
    t.text     "email"
    t.text     "url"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", using: :btree
  add_index "people", ["name_for_searching"], name: "index_people_on_name_for_searching", using: :btree

end
