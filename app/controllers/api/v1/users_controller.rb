class API::V1::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
