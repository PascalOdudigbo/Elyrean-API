class OrdersController < ApplicationController
  before_action :set_user # To ensure the user exists for context
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /users/:user_id/orders
  def index 
    @orders = @user.orders.all
    render json: @orders, include: [:shipping_address, :order_items, :refunds, :payment]
  end

  # GET /users/:user_id/orders/:id
  def show
    render json: @order, include: [:shipping_address, :order_items, :refunds, :payment]
  end

  # POST /users/:user_id/orders/
  def create
    @order = @user.orders.new(order_params)
    if @order.save
      render json: @order, include: [:shipping_address, :order_items, :refunds, :payment], status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:user_id/orders/:id
  def update
    if @order.update(order_params)
      render json: @order, include: [:shipping_address, :order_items, :refunds, :payment]
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  private 

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'User not found!'}, status: :not_found
  end

  def set_order
    @order = @user.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Order not found for this user!'}, status: :not_found
  end

  def order_params
    params.require(:order).permit(:total, :status, :shipping_address_id)
  end
end
