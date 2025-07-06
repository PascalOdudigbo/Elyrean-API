class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_item, only: [:update, :destroy]
  
  # GET /carts/:cart_id/cart_items
  def index 
    @cart_items = @cart.cart_items.all
    render json: @cart_items, include: [:product, :variation]
  end

  # POST /carts/:cart_id/cart_items/
  def create
    @cart_item = @cart.cart_items.new(cart_item_params)
    if @cart_item.save
      render json: @cart_item, include: [:product, :variation], status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/:cart_id/cart_items/:id
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
  def set_cart
    @cart = Cart.find(params[:cart_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Cart not found!'}, status: :not_found
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Cart item not found for this cart!'}, status: :not_found
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :variation_id, :quantity)
  end
end
