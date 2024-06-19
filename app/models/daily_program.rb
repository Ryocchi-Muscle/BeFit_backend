class DailyProgram < ApplicationRecord
  belongs_to :program_bundle
  has_many :training_menus, dependent: :destroy

  validates :week, presence: true
  validates :day, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true, on: :update
  validate :unique_date_per_program_bundle, on: :update

  def unique_date_per_program_bundle
    if date.present? && DailyProgram.where(program_bundle_id: program_bundle_id, week: week, day: day, date: date).exists?
      errors.add(:date, "You can only create one daily program per day for this program bundle")
    end
  end
end
