FactoryBot.define do
  factory :sensor do
    name 'DS18b20'
    write_key 'made_up'

    trait :with_readings do
      transient do
        data_count 5
      end
      
      after(:create) do |sensor, evaluator|
        create_list(:datum, evaluator.data_count, sensor: sensor)
      end
    end
  end
end
