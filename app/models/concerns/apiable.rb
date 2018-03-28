module Apiable
  extend ActiveSupport::Concern

  included do
    before_create :set_api_write_key
  end

  def set_api_write_key
    require 'securerandom'
    self.write_key = SecureRandom.urlsafe_base64
  end
end
