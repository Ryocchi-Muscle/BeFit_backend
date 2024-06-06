class ProgramBundle < ApplicationRecord
  belongs_to :user
  has_many :daily_programs, dependent: :destroy

  validates :gender, presence: true
  validates :frequency, presence: true
  validates :duration, presence: true
  validates :user_id, uniqueness: true
end
