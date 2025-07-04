class CartItemsController < ApplicationController
  before_action :get_cart_item, only: [:update, :destroy]
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      render json: @cart_item, include: [:product, :variation], status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      render json: @cart_item, include: [:product, :variation]
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item.destroy
    head :no_content
  end

  private

  def get_cart_item
    @cart_item = CartItem.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Cart item not found!'}, status: :not_found
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :product_variation_id, :quantity)
  end
end
