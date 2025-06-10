class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @user, include: [:role, :artist_profile] # Include the relevant associations
  end

  def show
    render json: @user, include: [:role, :artist_profile, :addresses, :orders]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content # 204 No Content
  end

  private 

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'User not found'}, status: :not_found
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role_id, :active, :stripe_customer_id)
  end
end
