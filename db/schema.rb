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

ActiveRecord::Schema[7.0].define(version: 2024_06_05_114816) do
  create_table "daily_programs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.json "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "program_bundle_id", null: false
    t.integer "week", null: false
    t.boolean "completed", default: false, null: false
    t.integer "day"
    t.index ["program_bundle_id", "week"], name: "index_daily_programs_on_bundle_week_day", unique: true
    t.index ["program_bundle_id"], name: "index_daily_programs_on_program_bundle_id"
  end

  create_table "program_bundles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "gender"
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration", null: false
    t.index ["user_id"], name: "index_program_bundles_on_user_id"
  end

  create_table "todos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_days", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_training_days_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_training_days_on_user_id"
  end

  create_table "training_menus", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "body_part"
    t.string "exercise_name"
    t.bigint "training_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "set_info"
    t.string "other"
    t.bigint "daily_program_id", null: false
    t.index ["training_day_id"], name: "index_training_menus_on_training_day_id"
  end

  create_table "training_sessions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_training_sessions_on_user_id"
  end

  create_table "training_sets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "set_number"
    t.integer "weight"
    t.integer "reps"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "training_menu_id", null: false
    t.index ["training_menu_id"], name: "index_training_sets_on_training_menu_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "program_bundles", "users", on_delete: :cascade
  add_foreign_key "training_days", "users", on_delete: :cascade
  add_foreign_key "training_menus", "training_days", on_delete: :cascade
  add_foreign_key "training_sets", "training_menus", on_delete: :cascade
end
