class CartsController < ApplicationController
  before_action :set_user
  before_action :set_cart, only: [:show]
  
  # GET /users/:user_id/carts
  def show
    render json: @cart, include: :cart_items
  end

  # POST /users/:user_id/carts/
  def create
    @cart = Cart.new(user_id: @user.id)
    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'User not found!'}, status: :not_found
  end

  def set_cart
    @cart = @user.cart
    unless @cart
      render json: {error: "Cart not found for this user!"}, status: :not_found
    end
  end

  # def cart_params
  #  params.require(:cart).permit()
  # end
end
