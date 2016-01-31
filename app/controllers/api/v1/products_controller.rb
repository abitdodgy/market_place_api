class API::V1::ProductsController < ApplicationController
  before_action :authenticate_with_token!, only: :create

  def index
    @products = policy_scope(Product)
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end

  def create
    @product = Product.new(owner: current_user)
    @product.assign_attributes permitted_attributes(@product)
    authorize @product
    if @product.save
      render :show, status: 201, location: [:api, @product]
    else
      render json: { errors: @product.errors }, status: 422
    end
  end
end
