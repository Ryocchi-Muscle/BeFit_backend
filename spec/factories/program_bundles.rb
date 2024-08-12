FactoryBot.define do
  factory :program_bundle do
    gender { "male" }
    frequency { 3 }
    duration { 12 }
    association :user
  end
end
