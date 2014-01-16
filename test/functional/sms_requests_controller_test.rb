require 'test_helper'

class SmsRequestsControllerTest < ActionController::TestCase
  setup do
    @sms_request = sms_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sms_request" do
    assert_difference('SmsRequest.count') do
      post :create, sms_request: { access_key: @sms_request.access_key, command: @sms_request.command, mo_message: @sms_request.mo_message, msisdn: @sms_request.msisdn, request_id: @sms_request.request_id, request_time: @sms_request.request_time, short_code: @sms_request.short_code, signature: @sms_request.signature }
    end

    assert_redirected_to sms_request_path(assigns(:sms_request))
  end

  test "should show sms_request" do
    get :show, id: @sms_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sms_request
    assert_response :success
  end

  test "should update sms_request" do
    put :update, id: @sms_request, sms_request: { access_key: @sms_request.access_key, command: @sms_request.command, mo_message: @sms_request.mo_message, msisdn: @sms_request.msisdn, request_id: @sms_request.request_id, request_time: @sms_request.request_time, short_code: @sms_request.short_code, signature: @sms_request.signature }
    assert_redirected_to sms_request_path(assigns(:sms_request))
  end

  test "should destroy sms_request" do
    assert_difference('SmsRequest.count', -1) do
      delete :destroy, id: @sms_request
    end

    assert_redirected_to sms_requests_path
  end
end
