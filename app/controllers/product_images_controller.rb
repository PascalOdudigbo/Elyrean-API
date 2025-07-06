class ProductImagesController < ApplicationController
  before_action :set_product # To ensure product exists for this context
  before_action :set_product_image, only: [:show, :update, :destroy]
  
  # GET /products/:product_id/product_images
  def index
    @product_images = @product.images.all
    render json: @product_images
  end

  # GET /products/:product_id/product_images/:id
  def show
    render json: @product_image
  end

  # POST /products/:product_id/product_images
  def create
    @product_image = @product.images.new(product_image_params)
    if @product_image.save
      render json: @product_image, status: :created, location: @product_image
    else
      render json: @product_image.errors, status: unprocessable_entity
    end
  end

  # PATCH/PUT /products/:product_id/product_images/:id
  def update
    if @product_image.update(product_image_params)
      render json: @product_image
    else
      render @product_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:product_id/product_images/:id
  def destroy
    @product_image.destroy
    head :no_content
  end

  private

  def set_product 
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product not found!'}, status: :not_found
  end 

  def set_product_image
    @product_image = @product.images.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product image not found for this product!'}, status: :not_found
  end

  def product_image_params
    params.require(:product_image).permit(:product_variation_id, :image_url, :image_public_id, :is_default)
  end
end
