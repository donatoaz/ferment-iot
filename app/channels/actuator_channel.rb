class ActuatorChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug "Subscribed to actuator channel"
    actuator = Actuator.find(params[:id])
    stream_for actuator, coder: ActiveSupport::JSON do |message|
      Rails.logger.debug "Received message #{message}"

      transmit message
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
