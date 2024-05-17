class User < ApplicationRecord
  has_many :training_days, dependent: :destroy
  has_many :training_sessions, dependent: :destroy

  validates :gender, presence: true
  validates :experience, presence: true
  validates :frequency, presence: true
  validates :duration, presence: true
  validates :level, presence: true
end
