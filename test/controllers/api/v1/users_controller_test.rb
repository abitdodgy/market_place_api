require 'test_helper'

class API::V1::UsersControllerTest < ActionController::TestCase
  setup do
    request.headers['Accept'] = "application/vnd.marketplace.v1,json"
  end

  test "GET #show returns info as a hash" do
    user = create(:user)
    get :show, id: user

    parse_response_body do |body|
      assert_equal user.name, body[:name]
      assert_equal user.email, body[:email]
    end

    assert_response :success
  end

  test "POST #create with valid attributes" do
    attributes = attributes_for(:user)

    assert_difference 'User.count', 1 do
      post :create, user: attributes
    end

    parse_response_body do |body|
      %i[name email].each do |attribute|
        assert_equal attributes[attribute], body[attribute]
      end
    end

    assert_response :created
  end

  test "POST #create with invalid attributes" do
    attributes = attributes_for(:user).except!(:email)

    assert_no_difference 'User.count' do
      post :create, user: attributes
    end

    parse_response_body do |body|
      assert_includes body, :errors
      assert_includes body[:errors][:email], "is invalid"
    end

    assert_response :unprocessable_entity
  end

  test "PATCH #update with valid attributes" do
    user = create(:user)

    patch :update, id: user, user: {
      name: "New Name"
    }

    parse_response_body do |body|
      assert_equal "New Name", body[:name]
    end

    assert_response :success
  end

  test "PATCH #update with invalid attributes" do
    user = create(:user)

    patch :update, id: user, user: {
      name: ""
    }

    parse_response_body do |body|
      assert_includes body, :errors
      assert_includes body[:errors][:name], "can't be blank"
    end

    assert_response :unprocessable_entity
  end

private

  def parse_response_body(&block)
    JSON.parse(response.body, symbolize_names: true).tap do |content|
      yield content if block_given?
    end
  end
end
