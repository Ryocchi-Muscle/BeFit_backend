FactoryBot.define do
  factory :user do
    uid { SecureRandom.uuid }
    name { Faker::Name.name }
    provider { "google" }
  end
end
