class Actuator < ApplicationRecord
  include Apiable

  enum output: [:on, :off]

  def turn_on
    self.update_attribute(:output, :on)
    return :on
  end

  def turn_off
    self.update_attribute(:output, :off)
    return :off
  end
end
