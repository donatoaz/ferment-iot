class Sensor < ApplicationRecord
  has_many :data
  include Apiable

  def last_reading
    data.last
  end
end
