class RenameWeekToDurationInProgramBundles < ActiveRecord::Migration[7.0]
  def change
    rename_column :program_bundles, :week, :duration
  end
end
