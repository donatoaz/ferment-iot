namespace :mqtt do
  desc "Listen for MQTT messages"
  task subscriber: :environment do
    require 'mqtt'
    client = MQTT::Client.connect(host: ENV['MQTT_BROKER_HOST'], username: 'mosquitto', port: ENV['MQTT_BROKER_PORT'])

    client.subscribe("sensor/#")
    #client.subscribe("actuator/#")

    client.get do |topic, message|
      _sensor, key = topic.split('/')
      puts "Received this: topic:#{topic}, sensor:#{_sensor}, key:#{key}, message:#{message}"
      if sensor = Sensor.find_by(write_key: key)
        SensorChannel.broadcast_to(sensor, { created_at: Time.now.to_s, value: message.to_s })
      else
        Rails.logger.debug "Subscriber unable to find sensor with api write_key: #{key}"
      end
    end
  end
end
