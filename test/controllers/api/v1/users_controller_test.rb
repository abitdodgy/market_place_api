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

  test "PATCH #update with valid attributes" do
    user = create(:user)
    patch :update, id: user, user: { name: "New Name" }

    assert_equal "New Name", json_response_body[:name]
    assert_response :success
  end

  test "PATCH #update with invalid attributes" do
    user = create(:user)
    patch :update, id: user, user: { name: nil }

    assert_includes json_response_body[:errors][:name], "can't be blank"
    assert_response :unprocessable_entity
  end

  test "DELETE #destroy deletes a user" do
    user = create(:user)

    assert_difference 'User.count', -1 do
      delete :destroy, id: user
    end

    assert_response :no_content
  end
end
