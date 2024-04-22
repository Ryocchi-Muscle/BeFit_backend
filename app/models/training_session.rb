class TrainingSession < ApplicationRecord
  belongs_to :user
  validates :start_date, presence: true

  # トレーニングセッションが開始してから経過した日数を計算するメソッド
  def elapesd_days
    return 0 if Date.today < start_date

    (Date.today - start_date).to_i + 1
  end

  # トレーニングセッションが開始するまでの残り日数を計算するメソッド
  def remaining_days
    return (start_date - Date.today).to_i if Date.today < start_date

    0
  end
end
