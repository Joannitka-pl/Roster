FactoryBot.define do
  factory :shift do
      studio { "1" }
      starting_at  { Time.now }
      duration { 8 }
  end
end