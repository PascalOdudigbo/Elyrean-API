class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_item, only: [:show, :update, :destroy]

  # GET /orders/:order_id/order_items
  def index
    @order_items = @order.order_items.all
    render json: @order_items, include: [:product, :variation]
  end

  # GET /orders/:order_id/order_items/:id
  def show
    render json: @order_item, include: [:product, :variation]
  end

  # POST /orders/:order_id/order_items/
  def create
    @order_item = @order.order_items.new(order_item_params)
    if @order_item.save
      render json: @order_item, include: [:product, :variation], status: :created, location: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:order_id/order_items/:id
  def update
    if @order_item.update(order_item_params)
      render json: @order_item, include: [:product, :variation]
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end  
  end

  # DELETE /orders/:order_id/order_items/:id
  def destroy
    @order_item.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error:  "Order not found!"}, status: :not_found
  end

  def set_order_item
    @order_item = @order.order_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Order item not found for this order!'}, status: :not_found
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :variation_id, :quantity, :price)
  end
end
