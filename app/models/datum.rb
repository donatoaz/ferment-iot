class Datum < ApplicationRecord
  belongs_to :sensor

  #serialize :measured_at, FormatedDateTime
  
  def measured_at_formatted
    self[:measured_at].strftime('%Y-%m-%d %H:%M:%S')
  end
end
