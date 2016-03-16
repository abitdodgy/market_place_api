class API::V1::ProductsController < ApplicationController
  before_action :authenticate_with_token!, only: %i[create update destroy]
  before_action :set_and_authorize_product!, only: %i[show update destroy]

  def index
    @products = policy_scope(Product)
  end

  def show
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

  def update
    if @product.update permitted_attributes(@product)
      render :show, status: 200, location: [:api, @product]
    else
      render json: { errors: @product.errors }, status: 422
    end
  end

  def destroy
    @product.destroy!
    head 204
  end

private

  def set_and_authorize_product!
    @product = Product.find(params[:id])
    authorize @product
  end
end
