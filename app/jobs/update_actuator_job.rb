class UpdateActuatorJob < ApplicationJob
  queue_as :default

  def perform(actuator_id, output)
    if actuator = Actuator.find(actuator_id)
      actuator.update_attribute(:output, output) if Actuator.outputs.keys.include?(output)
    else
      Rails.logger.error "UpdateActuatorJob#perform could not find Actuator with id #{actuator_id}"
    end
  end
end
