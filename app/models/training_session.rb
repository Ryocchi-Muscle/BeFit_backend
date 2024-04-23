class TrainingSession < ApplicationRecord
  belongs_to :user
  validates :start_date, presence: true

  # トレーニングセッションが開始してから経過した日数を計算するメソッド
  def elapsed_days
    today = Date.today
    if start_date.future?
      { remaining_days: (start_date - today).to_i }
    else
      { elapsed_days: (today - start_date).to_i + 1 }
    end
  end
end
