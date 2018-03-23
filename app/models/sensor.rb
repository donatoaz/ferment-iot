class Sensor < ApplicationRecord
  has_many :data

  before_create :set_api_write_key

  def set_api_write_key
    require 'securerandom'
    self.write_key = SecureRandom.urlsafe_base64
  end
end
