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

ActiveRecord::Schema.define(version: 2020_04_07_205444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "user_id", null: false
    t.string "answer"
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "available_at", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "available_at"], name: "index_availabilities_on_user_id_and_available_at", unique: true
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.decimal "number_of_sessions", precision: 8, scale: 2
  end

  create_table "profiles", force: :cascade do |t|
    t.string "short_description"
    t.string "long_description"
    t.string "qualifications"
    t.bigint "user_id"
    t.decimal "price", precision: 8, scale: 2
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "purchased_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trainer_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "external_id"
    t.string "currency"
    t.decimal "price", precision: 8, scale: 2
    t.string "payment_status"
    t.index ["option_id"], name: "index_purchased_sessions_on_option_id"
    t.index ["trainer_id"], name: "index_purchased_sessions_on_trainer_id"
    t.index ["user_id"], name: "index_purchased_sessions_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.text "options", default: [], array: true
    t.string "user_type"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "purchased_session_id", null: false
    t.datetime "session_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchased_session_id"], name: "index_sessions_on_purchased_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "sex"
    t.string "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
