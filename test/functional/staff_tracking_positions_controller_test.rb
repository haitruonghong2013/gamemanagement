require 'test_helper'

class StaffTrackingPositionsControllerTest < ActionController::TestCase
  setup do
    @staff_tracking_position = staff_tracking_positions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_tracking_positions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_tracking_position" do
    assert_difference('StaffTrackingPosition.count') do
      post :create, staff_tracking_position: { latitude: @staff_tracking_position.latitude, longitude: @staff_tracking_position.longitude, schedule_id: @staff_tracking_position.schedule_id, user_id: @staff_tracking_position.user_id }
    end

    assert_redirected_to staff_tracking_position_path(assigns(:staff_tracking_position))
  end

  test "should show staff_tracking_position" do
    get :show, id: @staff_tracking_position
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff_tracking_position
    assert_response :success
  end

  test "should update staff_tracking_position" do
    put :update, id: @staff_tracking_position, staff_tracking_position: { latitude: @staff_tracking_position.latitude, longitude: @staff_tracking_position.longitude, schedule_id: @staff_tracking_position.schedule_id, user_id: @staff_tracking_position.user_id }
    assert_redirected_to staff_tracking_position_path(assigns(:staff_tracking_position))
  end

  test "should destroy staff_tracking_position" do
    assert_difference('StaffTrackingPosition.count', -1) do
      delete :destroy, id: @staff_tracking_position
    end

    assert_redirected_to staff_tracking_positions_path
  end
end
