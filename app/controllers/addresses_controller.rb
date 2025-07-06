class AddressesController < ApplicationController
  before_action :set_user
  before_action :set_address, only: [:show, :update, :destroy]
  
  # GET /users/:user_id/addresses/
  def index
    @addresses = @user.addresses.all
    render json: @addresses
  end

  # GET /users/:user_id/addresses/:id
  def show
    render json: @address
  end

  # POST /users/:user_id/addresses/ 
  def create
    @address = @user.addresses.new(address_params)
    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:user_id/addresses/:id
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/addresses/:id
  def destroy
    @address.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'User not found!'}
  end 

  def set_address
    @address = @user.addresses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Address not found for this user!'}, status: :not_found
  end

  def address_params
    params.require(:address).premit(:address_line1, :address_line2, :city, :postal_code, :country)
  end

end
