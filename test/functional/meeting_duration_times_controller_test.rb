require 'test_helper'

class MeetingDurationTimesControllerTest < ActionController::TestCase
  setup do
    @meeting_duration_time = meeting_duration_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meeting_duration_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting_duration_time" do
    assert_difference('MeetingDurationTime.count') do
      post :create, meeting_duration_time: { actual_time: @meeting_duration_time.actual_time, estimate_time: @meeting_duration_time.estimate_time, meeting_id: @meeting_duration_time.meeting_id, variance: @meeting_duration_time.variance }
    end

    assert_redirected_to meeting_duration_time_path(assigns(:meeting_duration_time))
  end

  test "should show meeting_duration_time" do
    get :show, id: @meeting_duration_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting_duration_time
    assert_response :success
  end

  test "should update meeting_duration_time" do
    put :update, id: @meeting_duration_time, meeting_duration_time: { actual_time: @meeting_duration_time.actual_time, estimate_time: @meeting_duration_time.estimate_time, meeting_id: @meeting_duration_time.meeting_id, variance: @meeting_duration_time.variance }
    assert_redirected_to meeting_duration_time_path(assigns(:meeting_duration_time))
  end

  test "should destroy meeting_duration_time" do
    assert_difference('MeetingDurationTime.count', -1) do
      delete :destroy, id: @meeting_duration_time
    end

    assert_redirected_to meeting_duration_times_path
  end
end
