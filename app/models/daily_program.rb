class DailyProgram < ApplicationRecord
  belongs_to :program_bundle
  has_many :training_menus, dependent: :destroy

  validates :week, presence: true
  validates :day, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
