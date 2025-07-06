class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :update, :destroy]

  def index
    @discounts = Discount.all
    render json: @discounts
  end

  def show
    render json: @discount
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      render json: @discount, status: :created, location: @discount
    else
      render json: @discount.errors, status: :unprocessable_entity
    end
  end

  def update
    if @discount.update(discount_params)
      render json: @discount
    else
      render json: @discount.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @discount.destroy
    head :no_content
  end

  private

  def set_discount
    @discount = Discount.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Discount not found!"}, status: :not_found
  end

  def discount_params
    params.require(:discount).permit(:name, :description, :discount_percent, :image_url, :image_public_id, :valid_from, :valid_until)
  end
end
