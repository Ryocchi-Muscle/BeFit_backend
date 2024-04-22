class CreateTrainingSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :training_sessions do |t|
      t.references :user, null: false, foregin_key: true
      t.date :start_date
      
      t.timestamps
    end
  end
end
