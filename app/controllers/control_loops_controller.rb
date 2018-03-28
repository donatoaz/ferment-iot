class ControlLoopsController < ApplicationController
  before_action :set_control_loop, only: [:show, :edit, :update, :destroy]

  # GET /control_loops
  # GET /control_loops.json
  def index
    @control_loops = ControlLoop.all
  end

  # GET /control_loops/1
  # GET /control_loops/1.json
  def show
  end

  # GET /control_loops/new
  def new
    @control_loop = ControlLoop.new
  end

  # GET /control_loops/1/edit
  def edit
  end

  # POST /control_loops
  # POST /control_loops.json
  def create
    @control_loop = ControlLoop.new(control_loop_params)

    respond_to do |format|
      if @control_loop.save
        format.html { redirect_to @control_loop, notice: 'Control loop was successfully created.' }
        format.json { render :show, status: :created, location: @control_loop }
      else
        format.html { render :new }
        format.json { render json: @control_loop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /control_loops/1
  # PATCH/PUT /control_loops/1.json
  def update
    respond_to do |format|
      if @control_loop.update(control_loop_params)
        format.html { redirect_to @control_loop, notice: 'Control loop was successfully updated.' }
        format.json { render :show, status: :ok, location: @control_loop }
      else
        format.html { render :edit }
        format.json { render json: @control_loop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /control_loops/1
  # DELETE /control_loops/1.json
  def destroy
    @control_loop.destroy
    respond_to do |format|
      format.html { redirect_to control_loops_url, notice: 'Control loop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_control_loop
      @control_loop = ControlLoop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_loop_params
      params.require(:control_loop).permit(:name, :mode, :reference, :parameters, :sensor_id, :actuator_id)
    end
end
