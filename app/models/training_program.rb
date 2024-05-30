class TrainingProgram < ApplicationRecord
  belongs_to :user
  has_many :training_menus, dependent: :destroy

  scope :by_gender, ->(gender) { where(gender: gender) }
  scope :by_frequency, ->(frequency) { where(frequency: frequency) }
  scope :by_duration, ->(duration) { where('week <= ?', duration) }
end
