class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]
  
  def index
    @addresses = Address.all
    render json: @address, include: :user
  end

  def show
    render json: @address, include: :user
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    head :no_content
  end

  private

  def set_address
    @artist = Address.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Address not found'}, status: :not_found
  end

  def address_params
    params.require(:address).premit(:user_id, :address_line1, :address_line2, :city, :state, :postal_code, :country)
  end
end
