class CartsController < ApplicationController
  before_action :get_cart, only: [:show]

  def show
    render json: @cart, include: :cart_items
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def get_cart
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Cart not found!"}, status: :not_found
  end

  def cart_params
   params.require(:cart).permit(:user_id)
  end
end
