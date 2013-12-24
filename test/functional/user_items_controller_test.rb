require 'test_helper'

class UserItemsControllerTest < ActionController::TestCase
  setup do
    @user_item = user_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_item" do
    assert_difference('UserItem.count') do
      post :create, user_item: { atk: @user_item.atk, character_id: @user_item.character_id, def: @user_item.def, description: @user_item.description, health: @user_item.health, level: @user_item.level, name: @user_item.name, user_id: @user_item.user_id }
    end

    assert_redirected_to user_item_path(assigns(:user_item))
  end

  test "should show user_item" do
    get :show, id: @user_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_item
    assert_response :success
  end

  test "should update user_item" do
    put :update, id: @user_item, user_item: { atk: @user_item.atk, character_id: @user_item.character_id, def: @user_item.def, description: @user_item.description, health: @user_item.health, level: @user_item.level, name: @user_item.name, user_id: @user_item.user_id }
    assert_redirected_to user_item_path(assigns(:user_item))
  end

  test "should destroy user_item" do
    assert_difference('UserItem.count', -1) do
      delete :destroy, id: @user_item
    end

    assert_redirected_to user_items_path
  end
end
