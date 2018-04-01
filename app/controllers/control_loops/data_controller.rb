class ControlLoops::DataController < ApplicationController
  before_action :fetch_data

  def index
  end

  private
    def fetch_data
      @control_loop = ControlLoop.find(params[:control_loop_id])
      @sensor_data = @control_loop.sensor.data.order(measured_at: :desc)
      @reference_trackings = @control_loop.reference_trackings
    end

    def sensor_params
      params.require(:control_loop)
    end
end
