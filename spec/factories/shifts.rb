FactoryBot.define do
  time = Time.zone.now - rand(3000).days
  factory :shift do
    studio { Shift.studios.keys.sample }
    hour { Shift.hours.keys.sample }
    date { time.to_datetime }
  end
end
