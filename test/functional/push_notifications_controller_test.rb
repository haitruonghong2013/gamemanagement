require 'test_helper'

class PushNotificationsControllerTest < ActionController::TestCase
  setup do
    @push_notification = push_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:push_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create push_notification" do
    assert_difference('PushNotification.count') do
      post :create, push_notification: { device_id: @push_notification.device_id, notif: @push_notification.notif, reminder_for_next_meeting: @push_notification.reminder_for_next_meeting, reminder_for_take_note: @push_notification.reminder_for_take_note, time_reminder_befor_meeting_id: @push_notification.time_reminder_befor_meeting_id }
    end

    assert_redirected_to push_notification_path(assigns(:push_notification))
  end

  test "should show push_notification" do
    get :show, id: @push_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @push_notification
    assert_response :success
  end

  test "should update push_notification" do
    put :update, id: @push_notification, push_notification: { device_id: @push_notification.device_id, notif: @push_notification.notif, reminder_for_next_meeting: @push_notification.reminder_for_next_meeting, reminder_for_take_note: @push_notification.reminder_for_take_note, time_reminder_befor_meeting_id: @push_notification.time_reminder_befor_meeting_id }
    assert_redirected_to push_notification_path(assigns(:push_notification))
  end

  test "should destroy push_notification" do
    assert_difference('PushNotification.count', -1) do
      delete :destroy, id: @push_notification
    end

    assert_redirected_to push_notifications_path
  end
end
