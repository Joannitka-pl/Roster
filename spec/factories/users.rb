FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jannowak#{n}@example.com" }
    password { "123456" }
  end
end
