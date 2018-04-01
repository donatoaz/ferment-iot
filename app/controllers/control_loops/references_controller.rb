class ReferencesController < ApplicationController
  before_action :set_reference

  def show
  end

  def create
  end

  private
    def set_reference
      @control_loop = ControlLoop.find(params[:control_loop_id])
    end

    def reference_params
      params.require(:control_loop).permit(:reference)
    end
end
