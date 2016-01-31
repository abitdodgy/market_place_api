class API::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new
    @user.assign_attributes permitted_attributes(@user)
    if @user.save
      render :create, status: 201, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update permitted_attributes(@user)
      render :show, status: 200, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy!
    head 204
  end
end
