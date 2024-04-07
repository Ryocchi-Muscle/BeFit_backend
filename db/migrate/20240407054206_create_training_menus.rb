class CreateTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :training_menus do |t|
      t.string :body_part
      t.string :exercise_name
      t.references :training_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
