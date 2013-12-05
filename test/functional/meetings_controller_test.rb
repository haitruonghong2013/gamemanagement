require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase
  setup do
    @meeting = meetings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting" do
    assert_difference('Meeting.count') do
      post :create, meeting: { client_id: @meeting.client_id, created_by: @meeting.created_by, meeting_duration: @meeting.meeting_duration, meeting_time: @meeting.meeting_time, schedule_id: @meeting.schedule_id, status: @meeting.status, user_id: @meeting.user_id }
    end

    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should show meeting" do
    get :show, id: @meeting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting
    assert_response :success
  end

  test "should update meeting" do
    put :update, id: @meeting, meeting: { client_id: @meeting.client_id, created_by: @meeting.created_by, meeting_duration: @meeting.meeting_duration, meeting_time: @meeting.meeting_time, schedule_id: @meeting.schedule_id, status: @meeting.status, user_id: @meeting.user_id }
    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should destroy meeting" do
    assert_difference('Meeting.count', -1) do
      delete :destroy, id: @meeting
    end

    assert_redirected_to meetings_path
  end
end
