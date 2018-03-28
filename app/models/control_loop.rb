class ControlLoop < ApplicationRecord
  belongs_to :sensor
  belongs_to :actuator

  enum mode: [:auto, :manual, :inactive]

  def run
    # MAAAAJOR REFACTORING OPPORTUNITY
    # 1) NEGATIVE GAIN CONTROLLERS (REFRIGERATORS TURN ON TO REDUCE TEMP FOR EXAMPLE)
    if inactive?
      return :inactive
    elsif manual?
      return actuator.output
    elsif auto?
      if sensor.last_reading.value.to_f < reference
        return actuator.turn_off
      else
        return actuator.turn_on
      end
    end
  end
end
