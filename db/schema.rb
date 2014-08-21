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

ActiveRecord::Schema.define(version: 20140812054835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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
    t.text     "map_url"
    t.text     "map_image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.text     "name"
    t.text     "name_for_searching"
    t.text     "email"
    t.text     "phone"
    t.text     "url"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", using: :btree
  add_index "people", ["name_for_searching"], name: "index_people_on_name_for_searching", using: :btree

  create_table "signup_preferences", force: true do |t|
    t.integer  "signup_id",         null: false
    t.integer  "composer_night_id", null: false
    t.string   "status",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signup_preferences", ["composer_night_id", "signup_id"], name: "index_signup_preferences_on_composer_night_id_and_signup_id", unique: true, using: :btree
  add_index "signup_preferences", ["composer_night_id"], name: "index_signup_preferences_on_composer_night_id", using: :btree
  add_index "signup_preferences", ["signup_id", "composer_night_id"], name: "index_signup_preferences_on_signup_id_and_composer_night_id", unique: true, using: :btree
  add_index "signup_preferences", ["signup_id"], name: "index_signup_preferences_on_signup_id", using: :btree

  create_table "signups", force: true do |t|
    t.boolean  "active",            default: true
    t.integer  "presenter_id"
    t.integer  "composer_night_id"
    t.text     "comments"
    t.text     "internal_notes"
    t.text     "title"
    t.text     "performers"
    t.text     "approx_length"
    t.text     "description"
    t.text     "special_needs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "access_token"
  end

  add_index "signups", ["access_token"], name: "index_signups_on_access_token", unique: true, using: :btree
  add_index "signups", ["composer_night_id"], name: "index_signups_on_composer_night_id", using: :btree
  add_index "signups", ["created_at"], name: "index_signups_on_created_at", using: :btree
  add_index "signups", ["presenter_id"], name: "index_signups_on_presenter_id", using: :btree

end
