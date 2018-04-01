FactoryBot.define do
  factory :control_loop do
    name 'SISO'
    mode :auto
    reference 0
    association :sensor, :with_readings
    actuator

    trait :with_tracking do
      transient do
        _temp = 0
      end

      after(:create) do |control_loop, evaluator|
        control_loop.reference_trackings << create(:reference_tracking, value:0, target_datetime: Time.now - 1.day)
        control_loop.reference_trackings << create(:reference_tracking, value:100, target_datetime: Time.now + 1.day)
      end
    end
  end
end
