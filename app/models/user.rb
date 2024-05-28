class User < ApplicationRecord
  has_many :training_days, dependent: :destroy
  has_many :training_sessions, dependent: :destroy
  has_many :training_programs, dependent: :destroy
end
