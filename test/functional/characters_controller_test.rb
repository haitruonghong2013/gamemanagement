require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  setup do
    @character = characters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:characters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      post :create, character: { atk1: @character.atk1, atk2: @character.atk2, atk3: @character.atk3, ban: @character.ban, char_gender: @character.char_gender, char_name: @character.char_name, char_race: @character.char_race, def: @character.def, gold: @character.gold, hp: @character.hp, lose_number: @character.lose_number, lv: @character.lv, medal: @character.medal, mp: @character.mp, online: @character.online, user_id: @character.user_id, win_number: @character.win_number }
    end

    assert_redirected_to character_path(assigns(:character))
  end

  test "should show character" do
    get :show, id: @character
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @character
    assert_response :success
  end

  test "should update character" do
    put :update, id: @character, character: { atk1: @character.atk1, atk2: @character.atk2, atk3: @character.atk3, ban: @character.ban, char_gender: @character.char_gender, char_name: @character.char_name, char_race: @character.char_race, def: @character.def, gold: @character.gold, hp: @character.hp, lose_number: @character.lose_number, lv: @character.lv, medal: @character.medal, mp: @character.mp, online: @character.online, user_id: @character.user_id, win_number: @character.win_number }
    assert_redirected_to character_path(assigns(:character))
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete :destroy, id: @character
    end

    assert_redirected_to characters_path
  end
end
