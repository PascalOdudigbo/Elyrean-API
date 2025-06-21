class ProductVariationsController < ApplicationController
  before_action :get_product_variation only: [:show, :update, :destroy]
 
  def index
    @product_variations = ProductVariation.all
    render json: @product_variations
  end

  def show
    render json: @product_variation
  end

  def create
    @product_variation = ProductVariation.new(product_variation_params)
    if @product_variation.save
      render json: @product_variation, status: :created, location: @product_variation
    else
      render json: @product_variation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product_variation.update(product_variation_params)
      render json: @product_variation
    else
      render json: @product_variation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product_variation.destroy
    head :no_content
  end

  private

  def get_product_variation
    @product_variation = ProductVariation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product variation not found!'}, status: :not_found
  end

  def product_variation_params
    params.require(:product_variation).permit(:product_id, :size, :color, :price, :stock)
  end
end
