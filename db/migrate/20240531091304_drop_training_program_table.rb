class DropTrainingProgramTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :training_programs
  end

  def down
    create_table :training_programs, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "title"
      t.string "image"
      t.string "gender"
      t.string "frequency"
      t.integer "week"
      t.bigint "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_training_programs_on_user_id"
    end
  end
end
