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

ActiveRecord::Schema.define(version: 2020_06_01_103016) do

  create_table "addresses", force: :cascade do |t|
    t.string "state", limit: 40, null: false
    t.string "city", limit: 40, null: false
    t.string "street_name", limit: 25, null: false
    t.string "street_number", limit: 25, null: false
    t.string "zip", limit: 5, null: false
    t.string "apartament", limit: 5
    t.integer "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_addresses_on_buyer_id"
    t.index ["zip"], name: "index_addresses_on_zip"
  end

  create_table "artists", force: :cascade do |t|
    t.text "description", default: ""
    t.string "name", limit: 255
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "artists_fans", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "fan_id", null: false
    t.index ["artist_id", "fan_id"], name: "index_artists_fans_on_artist_id_and_fan_id"
  end

  create_table "audiences", force: :cascade do |t|
    t.integer "event_id"
    t.integer "fan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_audiences_on_event_id"
    t.index ["fan_id"], name: "index_audiences_on_fan_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.string "surname", limit: 30, null: false
    t.integer "dni", limit: 8, null: false
    t.string "phone", limit: 14
    t.string "phone_number", limit: 8
    t.string "phone_cod_area", limit: 5
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dni"], name: "index_buyers_on_dni"
    t.index ["email"], name: "index_buyers_on_email"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", limit: 40, null: false
    t.text "description"
    t.string "place", limit: 50
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["artist_id"], name: "index_events_on_artist_id"
  end

  create_table "fans", force: :cascade do |t|
    t.string "first_name", limit: 25, null: false
    t.string "last_name", limit: 25, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_states", force: :cascade do |t|
    t.datetime "date", null: false
    t.integer "orders_id", null: false
    t.integer "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orders_id"], name: "index_order_states_on_orders_id"
    t.index ["state_id"], name: "index_order_states_on_state_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "fan_id", null: false
    t.integer "state_id", null: false
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "units", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buyer_id"
    t.string "preference_id"
    t.integer "address_id"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["fan_id"], name: "index_orders_on_fan_id"
    t.index ["preference_id"], name: "index_orders_on_preference_id", unique: true
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["state_id"], name: "index_orders_on_state_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "product_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_photos_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.text "description", default: "No hay descripción de este producto"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "stock", default: 0, null: false
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_photos_amount", default: 10
    t.index ["artist_id"], name: "index_products_on_artist_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "description", limit: 40, null: false
    t.string "type", null: false
    t.string "name", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "username", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.string "profile_type"
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id", "profile_type"], name: "index_users_on_profile_id_and_profile_type"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
