class SensorChannel < ApplicationCable::Channel
  def subscribed
    sensor = Sensor.find(params[:id])
    stream_for sensor, coder: ActiveSupport::JSON do |message|
      transmit message
    end
  end
end
