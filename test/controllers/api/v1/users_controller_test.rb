require 'test_helper'

class API::V1::UsersControllerTest < ActionController::TestCase
  setup do
    include_default_request_headers
  end

  test "GET #show returns info as a hash" do
    user = create(:user)
    get :show, id: user

    json_response_body do |body|
      %i[name email auth_token].each do |attribute|
        assert_equal user.send(attribute), body[attribute]
      end
    end

    assert_response :success
  end

  test "POST #create with valid attributes" do
    attributes = attributes_for(:user)

    assert_difference 'User.count', 1 do
      post :create, user: attributes
    end

    json_response_body do |body|
      %i[name email].each do |attribute|
        assert_equal attributes[attribute], body[attribute]
      end

      assert_not_nil body[:auth_token]
    end

    assert_response :created
  end

  test "POST #create with invalid attributes" do
    attributes = attributes_for(:user).except!(:email)

    assert_no_difference 'User.count' do
      post :create, user: attributes
    end

    assert_includes json_response_body[:errors][:email], "is invalid"
    assert_response :unprocessable_entity
  end

  test "PATCH #update when not authenticated" do
    patch :update, id: 1
    assert_response :unauthorized
  end

  test "PATCH #update with valid attributes" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    patch :update, id: user, user: { name: "New Name" }

    assert_equal "New Name", json_response_body[:name]
    assert_response :success
  end

  test "PATCH #update with invalid attributes" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    patch :update, id: user, user: { name: nil }

    assert_includes json_response_body[:errors][:name], "can't be blank"
    assert_response :unprocessable_entity
  end

  test "DELETE #destroy not authenticated" do
    delete :destroy, id: 1
    assert_response :unauthorized
  end

  test "DELETE #destroy when same user" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    assert_difference 'User.count', -1 do
      delete :destroy, id: user
    end

    assert_response :no_content
  end

  test "DELETE #destroy when wrong user" do
    user = create(:user)
    other_user = create(:user)
    api_authorization_header token: user.auth_token

    assert_no_difference 'User.count' do
      delete :destroy, id: other_user
    end

    assert_response :forbidden
  end
end
