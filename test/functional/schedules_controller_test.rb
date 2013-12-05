require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  setup do
    @schedule = schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post :create, schedule: { am_working_hours_id: @schedule.am_working_hours_id, assigned_id: @schedule.assigned_id, average_meeting_duration: @schedule.average_meeting_duration, created_by: @schedule.created_by, ending_location_id: @schedule.ending_location_id, hq_location_id: @schedule.hq_location_id, pm_working_hours_id: @schedule.pm_working_hours_id, schedule_date: @schedule.schedule_date, speed: @schedule.speed, transport: @schedule.transport }
    end

    assert_redirected_to schedule_path(assigns(:schedule))
  end

  test "should show schedule" do
    get :show, id: @schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schedule
    assert_response :success
  end

  test "should update schedule" do
    put :update, id: @schedule, schedule: { am_working_hours_id: @schedule.am_working_hours_id, assigned_id: @schedule.assigned_id, average_meeting_duration: @schedule.average_meeting_duration, created_by: @schedule.created_by, ending_location_id: @schedule.ending_location_id, hq_location_id: @schedule.hq_location_id, pm_working_hours_id: @schedule.pm_working_hours_id, schedule_date: @schedule.schedule_date, speed: @schedule.speed, transport: @schedule.transport }
    assert_redirected_to schedule_path(assigns(:schedule))
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete :destroy, id: @schedule
    end

    assert_redirected_to schedules_path
  end
end
