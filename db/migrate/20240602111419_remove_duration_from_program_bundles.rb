class RemoveDurationFromProgramBundles < ActiveRecord::Migration[7.0]
  def change
    remove_column :program_bundles, :duration, :integer
  end
end
