class DiscountProductsController < ApplicationController
  before_action :get_discount_product, only: [:show, :destroy]

  def show
    render json: @discount_product
  end

  def create
    @discount_product = DiscountProduct.new(discount_product_params)
    if @discount_product.save
      render json: @discount_product, status: :created, location: @discount_product
    else
      render json: @discount_product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @discount_product.destroy
    head :no_content
  end

  private
  
  def get_discount_product
    @discount_product = DiscountProduct.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Discount product not found!"}, status: :not_found
  end

  def discount_product_params
    params.require(:discount_product).permit(:discount_id, :product_id)
  end
end
