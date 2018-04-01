class ControlLoop < ApplicationRecord
  belongs_to :sensor
  belongs_to :actuator
  has_many :reference_trackings

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

  def instant_reference(instant = Time.now)
    trackings = self.reference_trackings
    if !trackings.any?
      self.reference
    elsif trackings.count == 1
      trackings.first.value
    else
      previous_t = self.previous_reference_tracking(instant)
      next_t = self.next_reference_tracking(instant)
      if previous_t.nil?
        next_t.value
      elsif next_t.nil?
        previous_t.value
      else
        delta = previous_t.value == 0 ? next_t.value : next_t.value / previous_t.value
        percentage_period = (instant.to_i - previous_t.target_datetime.to_i)/(next_t.target_datetime.to_i - previous_t.target_datetime.to_i).to_f
        (previous_t.value + percentage_period * (next_t.value - previous_t.value)).round(2)
      end
    end
  end

  def previous_reference_tracking(ref = Time.now)
    self.reference_trackings.where('target_datetime < ?', ref).order(target_datetime: :desc).first
  end

  def next_reference_tracking(ref = Time.now)
    self.reference_trackings.where('target_datetime > ?', ref).order(target_datetime: :asc).first
  end
end
