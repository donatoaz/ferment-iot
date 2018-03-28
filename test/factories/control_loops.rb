FactoryBot.define do
  factory :control_loop do
    name 'SISO'
    mode :auto
    reference 0
    association :sensor, :with_readings
    actuator
  end
end
