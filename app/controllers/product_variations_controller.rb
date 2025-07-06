class ProductVariationsController < ApplicationController
  before_action :set_product
  before_action :set_product_variation only: [:show, :update, :destroy]
  
  # GET /products/:product_id/product_variations
  def index
    @product_variations = @product.variations.all
    render json: @product_variations, include: :images
  end

  # GET /products/:product_id/product_variations/:id
  def show
    render json: @product_variation, include: :images
  end

  # POST /products/:product_id/product_variations/
  def create
    @product_variation = @product.variations.new(product_variation_params)
    if @product_variation.save
      render json: @product_variation, status: :created, location: @product_variation
    else
      render json: @product_variation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:product_id/product_variations/:id
  def update
    if @product_variation.update(product_variation_params)
      render json: @product_variation, include: :images
    else
      render json: @product_variation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:product_id/product_variations/:id
  def destroy
    @product_variation.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product not found!'}, status: :not_found
  end

  def set_product_variation
    @product_variation = @product.variations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product variation not found for this product!'}, status: :not_found
  end

  def product_variation_params
    params.require(:product_variation).permit(:size, :color, :price, :stock)
  end
end
