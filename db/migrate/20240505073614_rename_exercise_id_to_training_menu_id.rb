class RenameExerciseIdToTrainingMenuId < ActiveRecord::Migration[7.0]
  def change
    # 環境がproductionの場合のみカラム名を変更する
    if Rails.env.production?
      rename_column :training_sets, :exercise_id, :training_menu_id
    end
  end
end
