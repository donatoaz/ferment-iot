class ControlLoopJob < ApplicationJob
  queue_as :run_control_loops

  def perform(control_loop_id)
    require Rails.root.join('lib', 'cervejator_mqtt').to_s

    controller = ControlLoop.find(control_loop_id)
    action = controller.run

    return if action == :inactive

    cli = Cervejator::MQTT.instance

    # parameters are: topic, payload, retain flag
    # the retain flag means that the broker will store the last message for
    # clients that subscribe later. Those will receive immediatelly the last
    # retained message.
    # IDEALLY WE WOULD SEND RETAINED MESSAGES, BUT UNTIL I FIND A WAY FOR THE
    # MOSQUITTO BROKER TO ONLY RETAIN THE LAST MESSAGE PER TOPIC, I WILL REFRAIN
    # FROM USING THIS, BECAUSE IT GENERATES A HUGE BACKLOG OF MESSAGES WHEN THE
    # SUBSCRIBER IS OFFLINE
    cli.publish("actuator/#{controller.actuator.write_key}", action, false, 1)

    controller.update_attribute(:next_run, Time.now + controller.sampling_rate.seconds)
  end
end
