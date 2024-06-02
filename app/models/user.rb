class User < ApplicationRecord
  has_many :training_days, dependent: :destroy
  has_many :training_sessions, dependent: :destroy
  has_one :program_bundle, dependent: :destroy
end
