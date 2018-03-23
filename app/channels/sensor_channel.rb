class SensorChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug "DEBUG: someone subscribed"
    sensor = Sensor.find(params[:id])
    stream_for sensor, coder: ActiveSupport::JSON do |message|
      Rails.logger.debug "Received message #{message}"

      transmit message
    end
  end
end
