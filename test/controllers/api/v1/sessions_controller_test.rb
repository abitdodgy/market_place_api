require 'test_helper'

class API::V1::SessionsControllerTest < ActionController::TestCase
  setup do
    include_default_request_headers
    @user = create(:user)
  end

  test "POST #create with correct credentials updates `user.auth_token`" do
    post :create, email: @user.email, password: @user.password

    json_response_body do |body|
      refute_equal @user.auth_token, body[:auth_token]
      assert_equal @user.reload.auth_token, body[:auth_token]

      expected = as_parsed_json(@user, only: [:id, :name, :email, :created_at, :auth_token])
      assert_equal expected, body
    end

    assert_response :success
  end

  test "POST #create with incorrect credentials" do
    post :create, email: @user.email, password: "incorrect"

    json_response_body do |body|
      assert_equal body[:errors], "Invalid username or password"
    end

    assert_response :unauthorized
  end

  test "DELETE #destroy" do
    delete :destroy, id: @user.auth_token
    refute_equal @user.auth_token, @user.reload.auth_token
  end
end
