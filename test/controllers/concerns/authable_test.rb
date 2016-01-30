require 'test_helper'

class DummyController < ApplicationController
  include Authable
end

class AuthableTest < ActionController::TestCase
  setup do
    include_default_request_headers
    @user = create(:user)
    request.headers['Authorization'] = @user.auth_token
    @dummy = DummyController.new
  end

  test "#current_user returns the use from the authorization header" do
    @dummy.stub(:request, request) do
      assert_equal @user.auth_token, @dummy.current_user.auth_token
    end
  end
end
