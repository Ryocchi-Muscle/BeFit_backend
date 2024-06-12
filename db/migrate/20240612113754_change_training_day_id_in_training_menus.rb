class ChangeTrainingDayIdInTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    change_column_null :training_menus, :training_day_id, true
  end
end
