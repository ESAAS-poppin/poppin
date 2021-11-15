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

ActiveRecord::Schema.define(version: 2021_11_10_014314) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "event_type"
    t.string "attire"
    t.string "price_range"
    t.integer "venue_id"
    t.datetime "date"
    t.integer "duration"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "following_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["following_user_id"], name: "index_followings_on_following_user_id"
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "saved_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_saved_events_on_event_id"
    t.index ["user_id"], name: "index_saved_events_on_user_id"
  end

  create_table "saved_venues", force: :cascade do |t|
    t.integer "user_id"
    t.integer "venue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_saved_venues_on_user_id"
    t.index ["venue_id"], name: "index_saved_venues_on_venue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.string "image_url"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "venue_admins", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "venue_type"
    t.string "attire"
    t.string "price_range"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "image_url"
    t.integer "venue_admin_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["venue_admin_id"], name: "index_venues_on_venue_admin_id"
  end

  add_foreign_key "events", "venues"
  add_foreign_key "followings", "users"
  add_foreign_key "followings", "users", column: "following_user_id"
  add_foreign_key "saved_events", "events"
  add_foreign_key "saved_events", "users"
  add_foreign_key "saved_venues", "users"
  add_foreign_key "saved_venues", "venues"
  add_foreign_key "venues", "venue_admins"
end
