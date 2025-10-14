class UserWishlistsController < ApplicationController
  before_action :set_user
  before_action :set_user_wishlist, only: :destroy
  
  # GET /users/:user_id/user_wishlists/
  def index
    @wishlist_items = @user.wishlist_items.all
    render json: @wishlist_items, include: [product: [:images]]
  end

  # POST /users/:user_id/user_wishlists/
  def create
    @wishlist_item = @user.wishlist_items.new(user_wishlist_params)
    if @wishlist_item.save
      render json: @wishlist_item, include: [product: [:images]], status: :created, location: @wishlist_item
    else
      render json: @wishlist_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/user_wishlists/:id
  def destroy
    @wishlist_item.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'User not found!'}, status: :not_found
  end

  def set_user_wishlist
    @user_wishlist = @user.wishlist_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Wishlist item not found for this user!'}
  end

  def user_wishlist_params
    params.require(:user_wishlist).permit(:product_id)
  end
end
