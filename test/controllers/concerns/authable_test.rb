require 'test_helper'

class DummyController < ApplicationController
  include Authable
end

class AuthableTest < ActionController::TestCase
  setup do
    include_default_request_headers
    @dummy = DummyController.new
  end

  test "#current_user returns the use from the authorization header" do
    user = create(:user)
    request.headers['Authorization'] = user.auth_token

    @dummy.stub(:request, request) do
      assert_equal user.auth_token, @dummy.current_user.auth_token
    end
  end

  test "#authenticate_with_token!" do
    request.headers['Authorization'] = :fake_token

    @dummy.stub(:request, request) do
      @dummy.instance_variable_set(:@_response, response)
      @dummy.authenticate_with_token!
    end

    assert_equal "Not authenticated", json_response_body[:errors]
    assert_response :unauthorized
  end
end
