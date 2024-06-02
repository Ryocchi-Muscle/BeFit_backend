class ProgramBundle < ApplicationRecord
  belongs_to :user
  has_many :daily_programs, dependent: :destroy
end
