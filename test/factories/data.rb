FactoryBot.define do
  factory :datum do
    created_at { Time.now }
    value { 10 }
    sensor
  end
end
