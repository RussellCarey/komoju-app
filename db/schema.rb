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

ActiveRecord::Schema[7.0].define(version: 2022_09_29_043031) do
  create_table "carts", force: :cascade do |t|
    t.string "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image", null: false
    t.string "name", null: false
    t.float "price", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.string "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image", null: false
    t.string "name", null: false
    t.float "price", null: false
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "game_purchases", force: :cascade do |t|
    t.string "game_id", null: false
    t.integer "discount", default: 0
    t.float "total", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.index ["user_id"], name: "index_game_purchases_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "messages", force: :cascade do |t|
    t.string "message", null: false
    t.boolean "blocked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "username", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "token_purchases", force: :cascade do |t|
    t.float "amount", null: false
    t.integer "discount", default: 0
    t.float "total", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_token_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.integer "phone_number"
    t.integer "reg_token"
    t.datetime "authorized_at"
    t.integer "prefered_contact", default: 1
    t.boolean "is_admin", default: false
    t.integer "token_count", default: 0
    t.string "komoju_customer"
    t.string "mobile_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carts", "users"
  add_foreign_key "favourites", "users"
  add_foreign_key "game_purchases", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "token_purchases", "users"
end
