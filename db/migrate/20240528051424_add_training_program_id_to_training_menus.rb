class AddTrainingProgramIdToTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :training_menus, :training_program_id, :bigint
  end
end
