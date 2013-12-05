require 'test_helper'

class ClientAnswersControllerTest < ActionController::TestCase
  setup do
    @client_answer = client_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_answer" do
    assert_difference('ClientAnswer.count') do
      post :create, client_answer: { client_id: @client_answer.client_id, content: @client_answer.content, question_id: @client_answer.question_id }
    end

    assert_redirected_to client_answer_path(assigns(:client_answer))
  end

  test "should show client_answer" do
    get :show, id: @client_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_answer
    assert_response :success
  end

  test "should update client_answer" do
    put :update, id: @client_answer, client_answer: { client_id: @client_answer.client_id, content: @client_answer.content, question_id: @client_answer.question_id }
    assert_redirected_to client_answer_path(assigns(:client_answer))
  end

  test "should destroy client_answer" do
    assert_difference('ClientAnswer.count', -1) do
      delete :destroy, id: @client_answer
    end

    assert_redirected_to client_answers_path
  end
end
