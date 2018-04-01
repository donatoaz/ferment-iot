class Cervejator::MQTT
  include Singleton

  def initialize
    begin
      @client = MQTT::Client.connect(host: ENV['MQTT_BROKER_HOST'], 
                                     username: 'mosquitto', 
                                     port: ENV['MQTT_BROKER_PORT'])
    rescue
      Rails.logger.error "Cervejator::MQTT.initialize client could not connect."
      @client = Class.new
      @client.define_singleton_method(:connected?) { false }
    end
  end

  def publish(topic, payload, retain = false, qos = 1)
    begin
      if @client.connected?
        Rails.logger.info "Cervejator::MQTT#publish publishing to #{topic}: #{payload}"
        # parameters are: topic, payload, retain flag
        # the retain flag means that the broker will store the last message for
        # clients that subscribe later. Those will receive immediatelly the last
        # retained message.
        @client.publish(topic, payload, retain, qos)
      else
        Rails.logger.error "Cervejator::MQTT#publish client is not connected. Attempting a reconnect..."
        raise Errno::ETIMEOUT
      end
    rescue
      initialize
      retry
    end
  end

  def connected?
    @client.connected?
  end
end
