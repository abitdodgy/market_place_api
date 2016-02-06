class API::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i[update destroy]
  before_action :set_and_authorize_user!, only: %i[show update destroy]

  def show
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
    if @user.update permitted_attributes(@user)
      render :show, status: 200, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def destroy
    @user.destroy!
    head 204
  end

private

  def set_and_authorize_user!
    @user = User.find(params[:id])
    authorize @user
  end
end
