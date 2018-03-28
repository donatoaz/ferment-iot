require 'test_helper'

class ControlLoopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @control_loop = control_loops(:one)
  end

  test "should get index" do
    get control_loops_url
    assert_response :success
  end

  test "should get new" do
    get new_control_loop_url
    assert_response :success
  end

  test "should create control_loop" do
    assert_difference('ControlLoop.count') do
      post control_loops_url, params: { control_loop: { actuator_id: @control_loop.actuator_id, mode: @control_loop.mode, name: @control_loop.name, parameters: @control_loop.parameters, reference: @control_loop.reference, sensor_id: @control_loop.sensor_id } }
    end

    assert_redirected_to control_loop_url(ControlLoop.last)
  end

  test "should show control_loop" do
    get control_loop_url(@control_loop)
    assert_response :success
  end

  test "should get edit" do
    get edit_control_loop_url(@control_loop)
    assert_response :success
  end

  test "should update control_loop" do
    patch control_loop_url(@control_loop), params: { control_loop: { actuator_id: @control_loop.actuator_id, mode: @control_loop.mode, name: @control_loop.name, parameters: @control_loop.parameters, reference: @control_loop.reference, sensor_id: @control_loop.sensor_id } }
    assert_redirected_to control_loop_url(@control_loop)
  end

  test "should destroy control_loop" do
    assert_difference('ControlLoop.count', -1) do
      delete control_loop_url(@control_loop)
    end

    assert_redirected_to control_loops_url
  end
end
