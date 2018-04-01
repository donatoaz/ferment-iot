class SensorChannel < ApplicationCable::Channel
  def subscribed
    sensor = Sensor.find(params[:id])
    stream_for sensor, coder: ActiveSupport::JSON do |message|
      Rails.logger.info "Transmitting message to sensor #{sensor.write_key}: #{message}"
      transmit message
    end
  end
end
