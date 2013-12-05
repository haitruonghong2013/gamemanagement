require 'test_helper'

class UserQuestionsControllerTest < ActionController::TestCase
  setup do
    @user_question = user_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_question" do
    assert_difference('UserQuestion.count') do
      post :create, user_question: { content: @user_question.content, question_id: @user_question.question_id, user_id: @user_question.user_id }
    end

    assert_redirected_to user_question_path(assigns(:user_question))
  end

  test "should show user_question" do
    get :show, id: @user_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_question
    assert_response :success
  end

  test "should update user_question" do
    put :update, id: @user_question, user_question: { content: @user_question.content, question_id: @user_question.question_id, user_id: @user_question.user_id }
    assert_redirected_to user_question_path(assigns(:user_question))
  end

  test "should destroy user_question" do
    assert_difference('UserQuestion.count', -1) do
      delete :destroy, id: @user_question
    end

    assert_redirected_to user_questions_path
  end
end
