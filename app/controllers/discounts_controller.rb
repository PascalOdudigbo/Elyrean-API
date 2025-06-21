class DiscountsController < ApplicationController
  before_action :get_discount, only: [:show, :update, :destroy]

  def index
    @discounts = Discount.all
    render json: @discounts
  end

  def show
    render json: @discount
  end

  def create
    @discount = discount.new(discount_params)
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

  def get_discount
    @discount = Discount.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Discount not fount!"}, status: :not_found
  end

  def discount_params
    params.require(:discount).premit(:name, :description, :discount_percent, :valid_from, :valid_until)
  end
end
