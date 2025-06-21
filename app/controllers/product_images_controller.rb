class ProductImagesController < ApplicationController
  before_action :get_product_image, only: [:show, :update, :destroy]
  
  def index
    @product_images = ProductImage.all
    render json: @product_images
  end

  def show
    render json: @product_image
  end

  def create
    @product_image = ProductImage.new(product_image_params)
    if @product_image.save
      render json: @product_image, status: :created, location: @product_image
    else
      render json: @product_image.errors, status: unprocessable_entity
    end
  end

  def update
    if @product_image.update(product_image_params)
      render json: @product_image
    else
      render @product_image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product_image.destroy
    head :no_content
  end

  private

  def get_product_image
    @product_image = ProductImage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product image not found!'}, status: :not_found
  end

  def product_image_params
    params.require(:product_image).permit(:product_id, :image_url, :image_public_id, :is_default)
  end
end
