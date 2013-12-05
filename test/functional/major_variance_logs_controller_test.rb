require 'test_helper'

class MajorVarianceLogsControllerTest < ActionController::TestCase
  setup do
    @major_variance_log = major_variance_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:major_variance_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create major_variance_log" do
    assert_difference('MajorVarianceLog.count') do
      post :create, major_variance_log: { created_by: @major_variance_log.created_by, datetime: @major_variance_log.datetime, latitude: @major_variance_log.latitude, longitude: @major_variance_log.longitude, meeting_id: @major_variance_log.meeting_id, variance: @major_variance_log.variance }
    end

    assert_redirected_to major_variance_log_path(assigns(:major_variance_log))
  end

  test "should show major_variance_log" do
    get :show, id: @major_variance_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @major_variance_log
    assert_response :success
  end

  test "should update major_variance_log" do
    put :update, id: @major_variance_log, major_variance_log: { created_by: @major_variance_log.created_by, datetime: @major_variance_log.datetime, latitude: @major_variance_log.latitude, longitude: @major_variance_log.longitude, meeting_id: @major_variance_log.meeting_id, variance: @major_variance_log.variance }
    assert_redirected_to major_variance_log_path(assigns(:major_variance_log))
  end

  test "should destroy major_variance_log" do
    assert_difference('MajorVarianceLog.count', -1) do
      delete :destroy, id: @major_variance_log
    end

    assert_redirected_to major_variance_logs_path
  end
end
