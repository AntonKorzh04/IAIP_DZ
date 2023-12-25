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

ActiveRecord::Schema[7.1].define(version: 2023_12_25_170511) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.index ["users_id"], name: "index_exercise_types_on_users_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_types_id"
    t.bigint "workouts_id"
    t.jsonb "sets"
    t.index ["exercise_types_id"], name: "index_exercises_on_exercise_types_id"
    t.index ["workouts_id"], name: "index_exercises_on_workouts_id"
  end

  create_table "posts", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.bigint "workouts_id"
    t.index ["users_id"], name: "index_posts_on_users_id"
    t.index ["workouts_id"], name: "index_posts_on_workouts_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.date "date"
    t.integer "body_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.index ["users_id"], name: "index_workouts_on_users_id"
  end

  add_foreign_key "exercise_types", "users", column: "users_id"
  add_foreign_key "exercises", "exercise_types", column: "exercise_types_id"
  add_foreign_key "exercises", "workouts", column: "workouts_id"
  add_foreign_key "posts", "users", column: "users_id"
  add_foreign_key "posts", "workouts", column: "workouts_id"
  add_foreign_key "workouts", "users", column: "users_id"
end
