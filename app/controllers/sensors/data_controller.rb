class Sensors::DataController < ApplicationController
  before_action :fetch_data

  def index
  end

  private
    def fetch_data
      @data = Sensor.find(params[:sensor_id]).data.order(measured_at: :desc) #.page(params[:page]).per(300)
    end

    def sensor_params
      params.require(:sensor)
    end
end
