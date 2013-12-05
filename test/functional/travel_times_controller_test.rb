require 'test_helper'

class TravelTimesControllerTest < ActionController::TestCase
  setup do
    @travel_time = travel_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_time" do
    assert_difference('TravelTime.count') do
      post :create, travel_time: { actual_time: @travel_time.actual_time, estimate_time: @travel_time.estimate_time, from_address: @travel_time.from_address, meeting_id: @travel_time.meeting_id, to_address: @travel_time.to_address, variance: @travel_time.variance }
    end

    assert_redirected_to travel_time_path(assigns(:travel_time))
  end

  test "should show travel_time" do
    get :show, id: @travel_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel_time
    assert_response :success
  end

  test "should update travel_time" do
    put :update, id: @travel_time, travel_time: { actual_time: @travel_time.actual_time, estimate_time: @travel_time.estimate_time, from_address: @travel_time.from_address, meeting_id: @travel_time.meeting_id, to_address: @travel_time.to_address, variance: @travel_time.variance }
    assert_redirected_to travel_time_path(assigns(:travel_time))
  end

  test "should destroy travel_time" do
    assert_difference('TravelTime.count', -1) do
      delete :destroy, id: @travel_time
    end

    assert_redirected_to travel_times_path
  end
end
