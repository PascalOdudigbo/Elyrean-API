class DiscountProductsController < ApplicationController
  before_action :set_discount
  before_action :set_discount_product, only: [:show, :destroy]
  
  #GET /discounts/:discount_id/discount_products/
  def index
    @discount_products = @discount.discount_products.all
    render json: @discount_products, include: [product: [:images]]
  end

  #GET /discounts/:discount_id/discount_products/:id
  def show
    render json: @discount_product, include: [product: [:images]] 
  end

  #POST /discounts/:discount_id/discount_products/
  def create
    @discount_product = @discount.discount_products.new(discount_product_params)
    if @discount_product.save
      render json: @discount_product, include: [products: [:images]], status: :created, location: @discount_product
    else
      render json: @discount_product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @discount_product.destroy
    head :no_content
  end

  private

  def set_discount
    @discount = Discount.find(params[:discount_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Discount not found!'}, status: :not_found
  end

  def set_discount_product
    @discount_product = @discount.discount_products.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Discount product not found for this discount!"}, status: :not_found
  end

  def discount_product_params
    params.require(:discount_product).permit(:product_id)
  end
end
