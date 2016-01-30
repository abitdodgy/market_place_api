class API::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      user.regenerate_auth_token
      render user, location: [:api, user]
    else
      render json: { errors: "Invalid username or password" }, status: 401
    end
  end

  def destroy
    if user = User.find_by(auth_token: params[:id])
      user.regenerate_auth_token
    end
    head 204
  end
end
