FactoryBot.define do
  factory :program do
    user { nil }
    gender { "MyString" }
    frequency { "MyString" }
    duration { 1 }
    details { "" }
  end
end
