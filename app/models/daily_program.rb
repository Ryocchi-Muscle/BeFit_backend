class DailyProgram < ApplicationRecord
  belongs_to :program_bundle
  has_many :training_menus, dependent: :destroy

  validates :week, presence: true
  validates :day, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true, allow_nil: true, on: :update
  validate :unique_date_per_program_bundle, if: :date_present?

  def unique_date_per_program_bundle
    return unless DailyProgram.where.not(id: id).where(program_bundle_id: program_bundle_id, date: date).exists?

    errors.add(:date, "You can only create one daily program per day for this program bundle")
  end

  private

    def date_present?
      date.present?
    end
end
