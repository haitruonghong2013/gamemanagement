require 'test_helper'

class StaticPageConfiguresControllerTest < ActionController::TestCase
  setup do
    @static_page_configure = static_page_configures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:static_page_configures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create static_page_configure" do
    assert_difference('StaticPageConfigure.count') do
      post :create, static_page_configure: { content: @static_page_configure.content, page_type: @static_page_configure.page_type }
    end

    assert_redirected_to static_page_configure_path(assigns(:static_page_configure))
  end

  test "should show static_page_configure" do
    get :show, id: @static_page_configure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @static_page_configure
    assert_response :success
  end

  test "should update static_page_configure" do
    put :update, id: @static_page_configure, static_page_configure: { content: @static_page_configure.content, page_type: @static_page_configure.page_type }
    assert_redirected_to static_page_configure_path(assigns(:static_page_configure))
  end

  test "should destroy static_page_configure" do
    assert_difference('StaticPageConfigure.count', -1) do
      delete :destroy, id: @static_page_configure
    end

    assert_redirected_to static_page_configures_path
  end
end
