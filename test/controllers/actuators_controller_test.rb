require 'test_helper'

class ActuatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @actuator = actuators(:one)
  end

  test "should get index" do
    get actuators_url
    assert_response :success
  end

  test "should get new" do
    get new_actuator_url
    assert_response :success
  end

  test "should create actuator" do
    assert_difference('Actuator.count') do
      post actuators_url, params: { actuator: { name: @actuator.name } }
    end

    assert_redirected_to actuator_url(Actuator.last)
  end

  test "should show actuator" do
    get actuator_url(@actuator)
    assert_response :success
  end

  test "should get edit" do
    get edit_actuator_url(@actuator)
    assert_response :success
  end

  test "should update actuator" do
    patch actuator_url(@actuator), params: { actuator: { name: @actuator.name } }
    assert_redirected_to actuator_url(@actuator)
  end

  test "should destroy actuator" do
    assert_difference('Actuator.count', -1) do
      delete actuator_url(@actuator)
    end

    assert_redirected_to actuators_url
  end
end
