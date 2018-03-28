class Sensors::DataController < ApplicationController
  before_action :fetch_data

  def index
  end

  private
    def fetch_data
      @data = Sensor.find(params[:sensor_id]).data.limit(20)
    end

    def sensor_params
      params.require(:sensor)
    end
end
