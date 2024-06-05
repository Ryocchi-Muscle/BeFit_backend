class DailyProgram < ApplicationRecord
  belongs_to :program_bundle
  has_many :training_menus, dependent: :destroy

  validates :week, presence: true
end
