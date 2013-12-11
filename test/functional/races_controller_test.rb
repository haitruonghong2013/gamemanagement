require 'test_helper'

class RacesControllerTest < ActionController::TestCase
  setup do
    @race = races(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:races)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race" do
    assert_difference('Race.count') do
      post :create, race: { atk1: @race.atk1, atk2: @race.atk2, atk3: @race.atk3, char_race: @race.char_race, def: @race.def, gold: @race.gold, hp: @race.hp, medal: @race.medal, mp: @race.mp }
    end

    assert_redirected_to race_path(assigns(:race))
  end

  test "should show race" do
    get :show, id: @race
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race
    assert_response :success
  end

  test "should update race" do
    put :update, id: @race, race: { atk1: @race.atk1, atk2: @race.atk2, atk3: @race.atk3, char_race: @race.char_race, def: @race.def, gold: @race.gold, hp: @race.hp, medal: @race.medal, mp: @race.mp }
    assert_redirected_to race_path(assigns(:race))
  end

  test "should destroy race" do
    assert_difference('Race.count', -1) do
      delete :destroy, id: @race
    end

    assert_redirected_to races_path
  end
end
