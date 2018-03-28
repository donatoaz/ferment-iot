class ControlLoopJob < ApplicationJob
  queue_as :control_loops

  def perform
    puts "TESTE"
    Rails.logger.debug "*********** DEBUG: I'm here"
  end

  def do_perform(control_loop_id)
    require 'mqtt'
    controller = ControlLoop.find(control_loop_id)
    action = controller.run

    return if action == :inactive

    MQTT::Client.connect(host: ENV['MQTT_BROKER_HOST'], 
                         username: 'mosquitto', 
                         port: ENV['MQTT_BROKER_PORT']) do |client|
      # parameters are: topic, payload, retain flag
      # the retain flag means that the broker will store the last message for
      # clients that subscribe later. Those will receive immediatelly the last
      # retained message.
      client.publish("actuators/#{controller.actuator.write_key}", action, true, 1)
    end
  end
end
