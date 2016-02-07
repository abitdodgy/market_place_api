class API::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!, only: %i[index show create]

  def index
    @orders = policy_scope(Order).includes(:user, products: :owner)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def create
    @order = Order.new(user: current_user)
    @order.assign_attributes permitted_attributes(@order)
    authorize @order
    if @order.dispatch!
      render :show, status: 201, location: [:api, @order]
    else
      render json: { errors: @order.errors }, status: 422
    end
  end
end
