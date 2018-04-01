class ControlLoops::ReferenceTrackingsController < ApplicationController
  before_action :set_control_loop, only: %i[ index create destroy ]
  before_action :set_reference_tracking, only: %i[ destroy ]

  def index
  end

  def create
    @reference_tracking = ReferenceTracking.new(reference_tracking_params)
    @reference_tracking.control_loop_id = @control_loop.id

    respond_to do |format|
      if @reference_tracking.save
        #format.json { render json: @reference_tracking, status: :created, location: @sensor }
        format.js
      else
        format.json { render json: @reference_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reference_tracking.destroy
    respond_to do |format|
      format.html { redirect_to @control_loop, notice: 'Reference tracking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_control_loop
      @control_loop = ControlLoop.find(params[:control_loop_id])
    end

    def reference_tracking_params
      params.require(:reference_tracking).permit(:value, :target_datetime)
    end
end
