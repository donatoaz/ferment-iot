namespace :mqtt do
  desc "Listen for MQTT messages"
  task subscriber: :environment do
    require 'mqtt'
    retry_count = 0
    begin
      client = MQTT::Client.connect(host: ENV['MQTT_BROKER_HOST'], username: 'mosquitto', port: ENV['MQTT_BROKER_PORT'])
      Rails.logger.info "MQTT Subscriber rake task connected to #{ENV['MQTT_BROKER_HOST']} on port #{ENV['MQTT_BROKER_PORT']}"

      client.subscribe("sensor/#")
      client.subscribe("actuator/#")

      client.get do |topic, message|
        device, key = topic.split('/')
        puts "Received this: topic:#{topic}, device:#{device}, key:#{key}, message:#{message}"
        case device
        when "sensor"
          if sensor = Sensor.find_by(write_key: key)
            value = message.to_f
            # broadcast reading to all listenners
            # assynchronously store data into databse
            reading_time = Time.zone.now
            reading = { measured_at: reading_time.to_formatted_s(:iso8601), 
                        measured_at_formatted: reading_time.strftime('%Y-%m-%d %H:%M:%S'),
                        value: value.to_s, sensor_id: sensor.id }
            SensorChannel.broadcast_to(sensor, reading)
            PersistDataJob.perform_later reading.slice(:measured_at, :value, :sensor_id)
          else
            Rails.logger.debug "Subscriber unable to find sensor with api write_key: #{key}"
          end
        when "actuator"
          if actuator = Actuator.find_by(write_key: key)

            # broadcast reading to all listenners
            ActuatorChannel.broadcast_to(actuator, message)
            # Update actuator status assynchronously
            UpdateActuatorJob.perform_later actuator.id, message
          else
            Rails.logger.debug "Subscriber unable to find actuator with api write_key: #{key}"
          end
        end
      end
    rescue MQTT::ProtocolException => e
      retry_count += 1
      Rails.logger.error "MQTT::ProtocolException error, #{e.message}. Going to Retry reconnection in 30 seconds"
      if retry_count <= 10
        sleep 30
        retry
      end
    rescue Errno::ETIMEDOUT => e
      Rails.logger.error "Errno::ETIMEDOUT error, #{e.message}. Going to Retry reconnection in 100 seconds"
      sleep 10
      retry
    rescue Errno::ENETUNREACH => e
      Rails.logger.error "Errno::ETIMEDOUT error, #{e.message}. Going to Retry reconnection in 100 seconds"
      sleep 60
      retry
    end
  end
end
