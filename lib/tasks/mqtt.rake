namespace :mqtt do
  desc "Listen for MQTT messages"
  task subscriber: :environment do
    require 'mqtt'
    client = MQTT::Client.connect(host: ENV['MQTT_BROKER_HOST'], username: 'mosquitto', port: ENV['MQTT_BROKER_PORT'])

    client.subscribe("sensor/#")
    #client.subscribe("actuator/#")

    last_value = 1000

    client.get do |topic, message|
      _sensor, key = topic.split('/')
      puts "Received this: topic:#{topic}, sensor:#{_sensor}, key:#{key}, message:#{message}"
      if sensor = Sensor.find_by(write_key: key)
        value = message.to_f
        if value > 1.3 * last_value
          value = last_value
        end
        last_value = value
        # broadcast reading to all listenners
        SensorChannel.broadcast_to(sensor, { created_at: Time.now.to_s, value: value.to_s })
        # assynchronously store data into databse
        reading = { measured_at: Time.now.to_s, value: value.to_s, sensor_id: sensor.id }
        PersistDataJob.perform_later reading
      else
        Rails.logger.debug "Subscriber unable to find sensor with api write_key: #{key}"
      end
    end
  end
end
