class ChangeWeightToDecimalInTrainingSets < ActiveRecord::Migration[7.0]
  def change
    change_column :training_sets, :weight, :decimal, precision: 5, scale: 2
  end
end
