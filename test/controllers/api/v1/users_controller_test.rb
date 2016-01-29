require 'test_helper'

class API::V1::UsersControllerTest < ActionController::TestCase
  setup do
    request.headers['Accept'] = "application/vnd.marketplace.v1"
  end

  test "GET #show returns info as a hash" do
    user = create(:user)
    get :show, id: user

    user_response = JSON.parse(response.body, symbolize_names: true)

    assert_equal user.email, user_response[:email]
    assert_response :success
  end
end
