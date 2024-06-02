class AddWeekToProgramBundles < ActiveRecord::Migration[7.0]
  def change
    add_column :program_bundles, :week, :integer, null: false
  end
end
