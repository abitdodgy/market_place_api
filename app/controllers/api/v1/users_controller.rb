class API::V1::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: 201, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :show, status: 200, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end