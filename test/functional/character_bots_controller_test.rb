require 'test_helper'

class CharacterBotsControllerTest < ActionController::TestCase
  setup do
    @character_bot = character_bots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:character_bots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create character_bot" do
    assert_difference('CharacterBot.count') do
      post :create, character_bot: { atk1: @character_bot.atk1, atk2: @character_bot.atk2, atk3: @character_bot.atk3, ban: @character_bot.ban, char_gender: @character_bot.char_gender, char_name: @character_bot.char_name, char_race: @character_bot.char_race, def: @character_bot.def, gold: @character_bot.gold, hp: @character_bot.hp, lose_number: @character_bot.lose_number, lv: @character_bot.lv, medal: @character_bot.medal, mp: @character_bot.mp, online: @character_bot.online, win_number: @character_bot.win_number }
    end

    assert_redirected_to character_bot_path(assigns(:character_bot))
  end

  test "should show character_bot" do
    get :show, id: @character_bot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @character_bot
    assert_response :success
  end

  test "should update character_bot" do
    put :update, id: @character_bot, character_bot: { atk1: @character_bot.atk1, atk2: @character_bot.atk2, atk3: @character_bot.atk3, ban: @character_bot.ban, char_gender: @character_bot.char_gender, char_name: @character_bot.char_name, char_race: @character_bot.char_race, def: @character_bot.def, gold: @character_bot.gold, hp: @character_bot.hp, lose_number: @character_bot.lose_number, lv: @character_bot.lv, medal: @character_bot.medal, mp: @character_bot.mp, online: @character_bot.online, win_number: @character_bot.win_number }
    assert_redirected_to character_bot_path(assigns(:character_bot))
  end

  test "should destroy character_bot" do
    assert_difference('CharacterBot.count', -1) do
      delete :destroy, id: @character_bot
    end

    assert_redirected_to character_bots_path
  end
end
