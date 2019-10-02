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

ActiveRecord::Schema.define(version: 2019_10_02_204951) do

  create_table "users", primary_key: "uuid", force: :cascade do |t|
    t.date "birthday"
    t.datetime "current_sign_in_at"
    t.integer "sign_in_count", default: 0, null: false
    t.integer "gender"
    t.string "avatar"
    t.string "current_sign_in_ip"
    t.string "email", limit: 254
    t.string "last_sign_in_ip"
    t.string "phone", limit: 11
    t.string "name", null: false
    t.string "nickname"
    t.string "reset_password_token"
    t.string "encrypted_password", default: ""
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_sign_in_at"
    t.integer "bitmask", default: 0, null: false
    t.string "http_user_agent", limit: 254
    t.boolean "avatar_processing", default: false, null: false
    t.string "cpf", limit: 11
    t.string "city"
    t.integer "state"
    t.integer "search_range", default: 20, null: false
    t.string "zipcode"
    t.string "street"
    t.string "street_number"
    t.datetime "password_token_expires_at"
    t.string "neighborhood"
    t.string "skype"
    t.string "complement"
    t.integer "source", default: 0
    t.integer "validation_code"
    t.integer "created_by_business"
    t.string "landline", limit: 11
    t.integer "application_source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
